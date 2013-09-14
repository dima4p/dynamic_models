require 'spec_helper'

describe "Proxies" do
  before(:each) do
    Proxy.table_name = 'examples'
    Proxy.connection.create_table 'examples'
    Proxy.connection.add_column 'examples', :name, :string
    Proxy.connection.add_column 'examples', :position, :integer
  end

  describe "GET /proxies" do
    it "works! (now write some real specs)" do
      get proxies_path(table_name: 'examples')
      response.status.should be(200)
    end
  end
end
