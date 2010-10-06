require 'yaml'

module Magento
  class Configuration
    DEFAULT_OPTIONS = {
      :wsdl_path => '/api/soap/?wsdl',
      :xmlrpc_path => '/api/xmlrpc',
      :port => '80'
    }

    @@file_path = nil

    class << self
      def default
        new(:file_path => default_file_path)
      end

      def default_file_path
        defined?(Rails) ? Rails.root.join('config', 'magento.yml') : '../../config/magento.yml'
      end
    end

    def initialize(raw_options = {})
      @raw_options = raw_options
    end

    def username
      options[:username]
    end

    def api_key
      options[:api_key]
    end

    def host
      options[:host]
    end

    def wsdl_path
      options[:wsdl_path]
    end

    def xmlrpc_path
      options[:xmlrpc_path]
    end

    def port
      options[:port]
    end

    private
      def options
        @options ||= DEFAULT_OPTIONS.merge(file_options).merge(@raw_options)
      end

      def file_options
        @file_options ||= (@raw_options[:file_path] and File.exists?(@raw_options[:file_path])) ?
          YAML.load_file(@raw_options[:file_path]) : {}
      end
  end
end
