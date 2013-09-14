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
      Proxy.connection.create_table 'examples'
      Proxy.connection.add_column 'examples', :name, :string
      Proxy.connection.add_column 'examples', :position, :integer
      Proxy.connection.add_column 'examples', :created_at, :datetime
      Proxy.connection.add_column 'examples', :updated_at, :datetime
      Proxy.visible_column_names.should == %w[name position]
      Proxy.connection.drop_table 'examples'
    end
  end

end
