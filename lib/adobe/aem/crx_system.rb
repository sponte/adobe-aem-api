module Adobe
  module Aem
    class CrxSystem
      def initialize(context)
        @context = context
      end

      def package_manager
        Adobe::Aem::Crx::PackageManager.new(@context)
      end
    end
  end
end
