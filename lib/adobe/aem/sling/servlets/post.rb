module Adobe
  module Aem
    module Sling
      module Servlets
        class Post

          def initialize(context)
            @context = context
          end

          def create(path, content)
            @context.connector.post(path, {
                content: content.to_json,
                contentType: 'json'
            })
          end
        end
      end
    end
  end
end