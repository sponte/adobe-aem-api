module Adobe
  module Aem
    class Configuration
      def initialize(options = {})
        @options = {
             hostname: 'localhost',
             port: 4502,
             username: 'admin',
             password: 'admin',
             http_debug: false
         }.merge(options)
      end

      def method_missing(name, *args)
        @options[name]
      end
    end
  end
end