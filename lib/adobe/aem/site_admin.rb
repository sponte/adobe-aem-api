module Adobe
  module Aem
    class SiteAdmin
      def initialize(context)
        @context = context
      end

      def content
        @context.connector.get('/content.1.json')
      end
    end
  end
end