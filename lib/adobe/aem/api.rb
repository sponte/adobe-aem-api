require 'adobe/aem/replication'
require 'adobe/aem/site_admin'
require 'adobe/aem/system'
require 'adobe/aem/crx_system'

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

      proxy :replication, Replication
      proxy :system, System
      proxy :crx, CrxSystem
      proxy :siteadmin, SiteAdmin

    end
  end
end
