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
  end

end
