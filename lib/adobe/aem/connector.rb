module Adobe
  module Aem
    class Connector
      def initialize(context)
        @context = context
      end

      def get(path)
        get = request(path)
        response = http.request(get)
        verify(response)

        json = parse_json(response.body)
        Adobe::Aem::Jcr::Node.new(json, path.gsub(/\.\d\.json/i, ''), @context)
      end

      def set(path, name, value)
        post = if value.is_a?(Hash)
                 value = {
                     ':content' => value.to_json,
                     ':contentType' => 'json',
                     ':operation' => 'import'
                 }

                 request("#{path}/#{name}", 'POST')
               else
                 value = {"./#{name}" => value}
                 request(path, 'POST')
               end

        post.set_form_data(value)

        response = http.request(post)
        verify(response)
      end

      def post(path, data, headers = {})
        post = request(path, 'POST')
        post.form_data = data if data

        response = http.request(post)
        verify(response)
      end

      def create_page(path, title, label, template, options = {})
        post = request('/bin/wcmcommand', 'POST')
        post.set_form_data({
                               cmd: 'createPage',
                               parentPath: path,
                               title: title,
                               label: label,
                               replace: true,
                               replaceProperties: true,
                               template: template
                           })
        response = http.request(post)
        verify(response)

        if options.size > 0
          set path, title, options
        end

        doc = Nokogiri::HTML(response.body)
        returned_path = doc.css('#Location').attr('href').value

        get("#{returned_path}.1.json")
      end

      def delete_page(path)
        post = request('/bin/wcmcommand', 'POST')
        post.set_form_data({
                               cmd: 'deletePage',
                               force: true,
                               path: path
                           })
        response = http.request(post)
        verify(response)
      end

      private
      def request(path, type='GET')
        r = if type == 'GET'
              Net::HTTP::Get.new(path)
            else
              Net::HTTP::Post.new(path)
            end
        r.basic_auth @context.configuration.username, @context.configuration.password
        r['Accept'] = 'application/json'
        r['Content-Type'] = 'application/json'
        r
      end

      def http
        return @http if @http

        @http = Net::HTTP.new(@context.configuration.hostname, @context.configuration.port)
        @http.set_debug_output $stderr if @context.configuration.http_debug
        @http
      end

      def verify(response)
        raise StandardError.new(response.class.to_s) unless
            [Net::HTTPOK, Net::HTTPCreated, Net::HTTPFound].include?(response.class)
      end

      def parse_json(string)
        json = JSON.parse(string)
        json = sanitise_jcr_json(json)

        json
      end

      def sanitise_jcr_json(json)
        new_hash = {}

        json.each do |key, value|
          new_hash[key] = value
          # new_hash[key.gsub(/[^\w]+/, '_')] = value
        end

        new_hash
      end
    end
  end
end