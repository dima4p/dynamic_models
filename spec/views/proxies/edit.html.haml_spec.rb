require 'spec_helper'

describe "proxies/edit" do
  before(:each) do
    Proxy.table_name = 'examples'
    assign(:table_name, 'examples')
    @proxy = assign(:proxy, stub_model(Proxy))
  end

  it "renders the edit proxy form" do
    render

    # rendered.should == ''
    assert_select "form[action=?][method=?]",
        proxy_path(@proxy, table_name: 'examples'), "post" do
      assert_select "input#proxy_name[name=?]", "proxy[name]"
      assert_select "input#proxy_position[name=?]", "proxy[position]"
    end
  end
end
