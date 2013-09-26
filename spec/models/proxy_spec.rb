require 'spec_helper'

describe Proxy do

  describe :class do
    it 'should respond to :table_name and :table_name=' do
      Proxy.table_name.should == 'proxies'
      Proxy.table_name = 'users'
      Proxy.table_name.should == 'users'
      Proxy.table_name = 'proxies'
    end

    it 'should respond to :visible_column_names' do
      Proxy.table_name = 'examples'
      Proxy.visible_column_names.should == %w[name position]
      Proxy.connection.drop_table 'examples'
    end

    it 'should respond to :visible_columns' do
      Proxy.table_name = 'examples'
      Proxy.visible_columns.should == {name: :string, position: :integer}
      Proxy.connection.drop_table 'examples'
    end

    it 'should reset the information after the table_name change' do
      begin
        Proxy.connection.create_table 'example1s'
        Proxy.connection.add_column 'example1s', :name1, :string
        Proxy.connection.add_column 'example1s', :position1, :integer
        Proxy.connection.add_column 'example1s', :created_at, :datetime
        Proxy.connection.add_column 'example1s', :updated_at, :datetime
        Proxy.table_name = 'examples'
        Proxy.visible_columns.should == {name: :string, position: :integer}
        Proxy.visible_column_names.should == %w[name position]
        Proxy.table_name = 'example1s'
        Proxy.table_name.should == 'example1s'
        Proxy.visible_columns.should == {name1: :string, position1: :integer}
        Proxy.visible_column_names.should == %w[name1 position1]
      ensure
        Proxy.connection.drop_table 'example1s'
      end
    end
  end

end
