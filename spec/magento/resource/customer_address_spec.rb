require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::CustomerAddress do
  context '.list' do
    it 'should send \'customer_address.list\' to Magento and return a collection of customer addresses' do
      Magento::Test.stub_service :method => 'customer_address.list',
        :arguments => ['1'],
        :response => [{'city' => 'New York', 'region' => 'New York', 'street' => ['1 West 72nd St.']}]

      customer_addresses = Magento::CustomerAddress.list '1'
      customer_addresses.first.should be_a Magento::CustomerAddress
      customer_addresses.first.city.should == 'New York'
    end
  end

  context '.create' do
    it 'should send \'customer_address.create\' to Magento and return a customer address instance' do
      Magento::Test.stub_service :method => 'customer_address.create',
        :arguments => ['1', {'city' => 'New York', 'region' => 'New York', 'street' => ['1 West 72nd St.']}],
        :response => ['1']

      customer_address = Magento::CustomerAddress.create '1', :city => 'New York', :region => 'New York',
        :street => ['1 West 72nd St.']
      customer_address.should be_a Magento::CustomerAddress
      customer_address.city.should == 'New York'
    end
  end

  context '.info' do
    it 'should send \'customer_address.info\' to Magento and return a hash of attributes' do
      Magento::Test.stub_service :method => 'customer_address.info',
        :arguments => ['1'],
        :response => {'city' => 'New York', 'region' => 'New York', 'street' => ['1 West 72nd St.']}

      attributes = Magento::CustomerAddress.info('1')
      attributes[:city].should == 'New York'
    end
  end

  context '#update' do
    it 'should send \'customer_address.update\' to Magento with the specified attributes' do
      Magento::Test.stub_service :method => 'customer_address.update',
        :arguments => ['1', {'city' => 'New York', 'region' => 'New York'}],
        :response => true

      customer_address = Magento::CustomerAddress.new(:customer_address_id => '1', :city => 'Bronx', :region => 'New York')
      customer_address.update(:city => 'New York')
      customer_address.city.should == 'New York'
    end
  end

  context '#delete' do
    it 'should send \'customer_address.delete\' to Magento with the resource_id' do
      Magento::Test.stub_service :method => 'customer_address.delete',
        :arguments => ['1'],
        :response => true

      customer = Magento::CustomerAddress.new(:customer_address_id => '1')
      customer.delete
    end
  end
end
