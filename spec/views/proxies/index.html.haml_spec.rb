require 'spec_helper'

describe "proxies/index" do
  before(:each) do
    Proxy.table_name = 'examples'
    Proxy.connection.create_table 'examples'
    Proxy.connection.add_column 'examples', :name, :string
    Proxy.connection.add_column 'examples', :position, :integer
    assign(:table_name, 'examples')
    assign(:proxies, [
      stub_model(Proxy, name: 'Proxy', position: 5),
      stub_model(Proxy, name: 'Proxy', position: 5)
    ])
  end

  it "renders a list of proxies" do
    render
    # rendered.should == ''

    assert_select "tr>td", :text => "Proxy".to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
