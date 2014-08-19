module Adobe
  module Aem
    class Replication
      def initialize(context)
        @context = context
      end

      def agents
        @context.connector.get('/etc/replication.1.json')
      end

      # AgentyType can be empty for default replication agent, rev for reverse and static for static
      def create_agent(type, name, options = {}, agentType = '')
        # agent, revagent, staticagent
        @context.connector.create_page("/etc/replication/#{type}", name, name, "/libs/cq/replication/templates/#{agentType}agent", options)
      end

      def delete_agent(type, name)
        @context.connector.delete_page("/etc/replication/#{type}/#{name}")
      end
    end
  end
end