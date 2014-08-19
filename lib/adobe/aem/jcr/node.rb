module Adobe
  module Aem
    module Jcr
      class Node
        def initialize(hash = {}, path, context)
          @context = context
          @path = path
          @data = hash
        end

        def children
          @data.select do |key, value|
            value.is_a? Hash
          end
        end

        def jcr_content
          self.send('jcr:content')
        end

        def jcr_content=(value)
          self.send('jcr:content=', value)
        end

        def child_exists?(name)
          @data.has_key?(name)
        end

        def create_child(title, options = {})
          options = {
              title: title,
              label: title,
              template: ''
          }.merge(options)

          @connector.create_page(@path, options[:title], options[:label], options[:template])
        end

        def method_missing(name, *args, &block)
          # If we're trying to set content of a node that doesn't exist
          # we should throw exception
          #
          # /bin/wcmcommand
          # cmd:createPage
          # parentPath:/etc/replication/agents.author
          # title:Test
          # label:Test
          # template:/libs/cq/replication/templates/agent

          setter = name =~ /=$/

          if name.to_s =~ /^\[\]/
            name = args.delete_at(0)
          end

          if setter
            return set(name, *args)
          end

          unless @data[name.to_s].is_a?(Hash)
            return @data[name.to_s]
          end

          if name.to_s =~ /=$/

          else
            @context.connector.get("#{@path}/#{name}.1.json")
          end
        end

        def length
          children.length
        end
        alias :size :length

        private
        def set(name, value)
          field_name = name.to_s.gsub(/=$/, '')
          puts "Setting #{@path} #{field_name} to #{value}"
          @context.connector.set(@path, field_name, value)
        end
      end
    end
  end
end