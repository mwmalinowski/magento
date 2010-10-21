require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Customer do
  context '.list' do
    it 'should send \'customer.list\' to Magento and return a collection of customers' do
      Magento::Test.stub_service :method => 'customer.list',
        :arguments => [{'lastname' => 'Rothstein'}],
        :response => [{'customer_id' => '1', 'firstname' => 'Arnold', 'lastname' => 'Rothstein'}]

      customers = Magento::Customer.list :lastname => 'Rothstein'
      customers.first.should be_a Magento::Customer
      customers.first.firstname.should == 'Arnold'
    end
  end

  context '.create' do
    it 'should send \'customer.create\' to Magento and return a Customer object' do
      Magento::Test.stub_service :method => 'customer.create',
        :arguments => [{'firstname' => 'Arnold', 'lastname' => 'Rothstein', 'email' => 'arothstein@example.com'}],
        :response => '1'

      customer = Magento::Customer.create(:firstname => 'Arnold', :lastname => 'Rothstein', :email => 'arothstein@example.com')
      customer.should be_a Magento::Customer
      customer.lastname.should == 'Rothstein'
    end
  end

  context '.info' do
    it 'should send \'customer.info\' to Magento and return a hash of attributes' do
      Magento::Test.stub_service :method => 'customer.info',
        :arguments => ['1'],
        :response => {'customer_id' => '1', 'firstname' => 'Arnold', 'lastname' => 'Rothstein', 'email' => 'arothstein@example.com'}

      attributes = Magento::Customer.info('1')
      attributes[:firstname].should == 'Arnold'
    end
  end

  context '#update' do
    it 'should send \'customer.update\' to Magento with the specified attributes' do
      Magento::Test.stub_service :method => 'customer.update',
        :arguments => ['1', {'firstname' => 'Arnold', 'lastname' => 'Rothstein'}],
        :response => true

      customer = Magento::Customer.new(:customer_id => '1', :firstname => 'George')
      customer.update(:firstname => 'Arnold', :lastname => 'Rothstein')
      customer.firstname.should == 'Arnold'
    end
  end

  context '#delete' do
    it 'should send \'customer.delete\' to Magento with the resource_id' do
      Magento::Test.stub_service :method => 'customer.delete',
        :arguments => ['1'],
        :response => true

      customer = Magento::Customer.new(:customer_id => '1')
      customer.delete
    end
  end
end
