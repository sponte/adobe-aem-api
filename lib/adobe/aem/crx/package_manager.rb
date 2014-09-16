module Adobe
  module Aem
    module Crx
      class PackageManager

        def initialize(context)
          @context = context
        end

        def install(package_path)
          @context.connector.post("/crx/packmgr/service/.json/etc/packages#{package_path}?cmd=install")
        end

      end
    end
  end
end
