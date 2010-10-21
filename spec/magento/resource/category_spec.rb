require File.dirname(__FILE__) + '/../../spec_helper'

describe Magento::Category do
  context '.current_store' do
    it 'should send \'category.currentStore\' to Magento and return a the ID' do
      Magento::Test.stub_service :method => 'category.currentStore',
        :arguments => [],
        :response => '123'

      Magento::Category.current_store.should == '123'
    end
  end

  context '.current_store=' do
    it 'should send \'category.currentStore\' to Magento with the specified store_view' do
      Magento::Test.stub_service :method => 'category.currentStore',
        :arguments => ['123'],
        :response => '123'

      Magento::Category.current_store = '123'
    end
  end

  context '.tree' do
    it 'should send \'category.tree\' to Magento with the specified options for parent_id and store_view' do
      Magento::Test.stub_service :method => 'category.tree',
        :arguments => ['123', '456'],
        :response => mock(:category_tree)

      Magento::Category.tree :parent_id => '123', :store_view => '456'
    end
  end

  context '.level' do
    it 'should send \'category.level\' to Magento with the specified options for website, store_view and parent_id' do
      Magento::Test.stub_service :method => 'category.level',
        :arguments => ['123', '456', '789'],
        :response => mock(:category_level)

      Magento::Category.level :website => '123', :store_view => '456', :parent_id => '789'
    end
  end

  context '.info' do
    it 'should send \'category.info\' to Magento with the specified resource_id and store_view and return attributes' do
      Magento::Test.stub_service :method => 'category.info',
        :arguments => ['123', '456'],
        :response => {'name' => 'Apparel'}

      attributes = Magento::Category.info '123', :store_view => '456'
      attributes[:name].should == 'Apparel'
    end
  end

  context '.create' do
    it 'should send \'category.create\' to Magento with the specified attributes and return a Magento::Category' do
      Magento::Test.stub_service :method => 'category.create',
        :arguments => ['123', {'name' => 'Apparel'}, '456'],
        :response => '1'

      category = Magento::Category.create :parent_id => '123', :store_view => '456', :name => 'Apparel'
      category.should be_a(Magento::Category)
      category.name.should == 'Apparel'
    end
  end

  context '#update' do
    it 'should send \'category.update\' to Magento with the specified attributes' do
      Magento::Test.stub_service :method => 'category.update',
        :arguments => ['1', {'name' => 'Automotive'}, '123'],
        :response => true

      category = Magento::Category.new(:category_id => '1', :name => 'Apparel')
      category.update(:name => 'Automotive', :store_view => '123')
      category.name.should == 'Automotive'
    end
  end

  context '#move' do
    it 'should send \'category.move\' to Magento with the specified parent_id and after_id' do
      Magento::Test.stub_service :method => 'category.move',
        :arguments => ['1', '123', '456'],
        :response => true

      category = Magento::Category.new(:category_id => '1')
      category.move :parent_id => '123', :after_id => '456'
    end
  end

  context '#delete' do
    it 'should send \'category.delete\' to Magento with the resource_id' do
      Magento::Test.stub_service :method => 'category.delete',
        :arguments => ['1'],
        :response => true

      category = Magento::Category.new(:category_id => '1')
      category.delete
    end
  end
end