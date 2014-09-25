module Adobe
  module Aem
    class Api
      attr_reader :context

      class << self
        def proxy(name, klass)
          define_method name do
            klass.new(@context)
          end
        end
      end

      def initialize(options = {})
        @context = Context.new
        @context.configuration = Configuration.new(options)
        @context.connector = Connector.new(@context)
      end

      require 'adobe/aem/replication'
      proxy :replication, Replication

      def siteadmin
        @siteadmin ||= SiteAdmin.new(@context)
      end

      def system
        @system ||= System.new(@context)
      end

      def crx
        @crx ||= CrxSystem.new(@context)
      end
    end
  end
end
