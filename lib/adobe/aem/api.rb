module Adobe
  module Aem
    class Api
      attr_reader :context

      def initialize(options = {})
        @context = Context.new
        @context.configuration = Configuration.new(options)
        @context.connector = Connector.new(@context)
      end

      def replication
        Replication.new(@context)
      end

      def siteadmin
        SiteAdmin.new(@context)
      end
    end
  end
end
