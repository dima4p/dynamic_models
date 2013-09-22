require 'spec_helper'

describe "proxies/new" do
  before(:each) do
    Proxy.table_name = 'examples'
    assign(:table_name, 'examples')
    @proxy = assign(:proxy, stub_model(Proxy).as_new_record)
  end

  it "renders new proxy form" do
    render

    # rendered.should == ''
    assert_select "form[action=?][method=?]",
        proxies_path(table_name: 'examples'), "post" do
      assert_select "input#proxy_name[name=?]", "proxy[name]"
      assert_select "input#proxy_position[name=?]", "proxy[position]"
    end
  end
end
