require 'xmlrpc/client'

module Magento
  class Connection
    @@default = nil

    class << self
      def default
        @@default ||= new(Magento::Configuration.default)
      end

      def scrub_method(method)
        method.to_s
      end

      def scrub_arguments(arguments)
        arguments.map do |argument|
          argument.is_a?(Hash) ?
            argument.inject({}){|hash, pair| hash[pair[0].to_s] = pair[1].to_s; hash} :
            argument.to_s
        end
      end

      def scrub_response(response)
        case response
        when Hash then response.inject({}){|hash, pair| hash[pair[0].to_sym] = pair[1]; hash}
        when Array then response.map{|item| scrub_response(item)}
        else response
        end
      end
    end

    attr_reader   :session_id
    attr_accessor :configuration

    def initialize(configuration)
      @configuration = configuration
    end

    def call(raw_method, *raw_arguments)
      log_in unless logged_in?

      method = Magento::Connection.scrub_method(raw_method)
      arguments = Magento::Connection.scrub_arguments(raw_arguments)
      raw_response = client.call('call', @session_id, method, *arguments)
      Magento::Connection.scrub_response(raw_response)
    end

    def log_in
      if @configuration.username and @configuration.api_key
        @session_id = client.call('login', @configuration.username, @configuration.api_key)
      end
    end

    def logged_in?
      !@session_id.nil?
    end

    private
      def client
        @client ||= XMLRPC::Client.new(@configuration.host, @configuration.path, @configuration.port)
      end
  end
end
