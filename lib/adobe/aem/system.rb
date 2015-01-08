

module Adobe
  module Aem
    class System
      def initialize(context)
        @context = context
      end

      def update_configuration(name, options)
        @context.connector.post("/system/console/configMgr/#{name}", options)
      end

      def uninstall_bundle(name)
        @context.connector.post("/system/console/bundles/#{name}", action: 'uninstall')
      end
      def stop_bundle(name)
        @context.connector.post("/system/console/bundles/#{name}", action: 'stop')
      end
      def start_bundle(name)
        @context.connector.post("/system/console/bundles/#{name}", action: 'start')
      end

      def refresh_bundle_imports(name)
        @context.connector.post("/system/console/bundles/#{name}", action: 'refresh')
      end

      def install_bundle(path)
        options = {
          action: :install,
          bundleStartLevel: 20
        }

        raise "File: #{path} does not exist" unless File.exists?(path)
        options[:bundlefile] = UploadIO.new(path, 'application/java-archive')

        @context.connector.multipart_post('/system/console/bundles', options)
      end
    end
  end
end