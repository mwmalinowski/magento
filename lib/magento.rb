$:.unshift File.expand_path(File.dirname(__FILE__))

require 'rubygems'
require 'active_support/concern'
require 'active_support/dependencies/autoload'

module Magento
  extend ActiveSupport::Autoload

  autoload :Configuration
  autoload :Connection

  autoload_under 'resource' do
    autoload :Customer
  end

  autoload_under 'concern' do
    autoload :Attributable
    autoload :Connectable
    autoload :Creatable
    autoload :Deletable
    autoload :Findable
    autoload :Infoable
    autoload :Listable
    autoload :Reloadable
    autoload :Resource
    autoload :Savable
    autoload :Updatable
  end

  @@connection = nil

  def self.connection
    @@connection ||= Magento::Connection.default
  end

  def self.connection=(connection)
    @@connection = connection
  end
end
