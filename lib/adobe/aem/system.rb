module Adobe
  module Aem
    class System
      def initialize(context)
        @context = context
      end

      def update_configuration(name, options)
        @context.connector.post("/system/console/configMgr/#{name}", options)
      end
    end
  end
end