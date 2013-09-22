require 'spec_helper'

describe "proxies/index" do
  before(:each) do
    Proxy.table_name = 'examples'
    assign(:table_name, 'examples')
    assign(:proxies, [
      stub_model(Proxy, name: 'Proxy', position: 5),
      stub_model(Proxy, name: 'Proxy', position: 5)
    ])
  end

  it "renders a list of proxies" do
    render
    # rendered.should == ''

    assert_select "form[action=?][method=?]",
        update_column_proxies_path(table_name: 'examples'), "post" do
      assert_select "tr>td", :text => "Proxy".to_s, :count => 2
      assert_select "tr>td", :text => 5.to_s, :count => 2
      assert_select "input#taken[name=?][type=?]", "taken", 'hidden'
      assert_select "input#attribute[name=?][type=?]", "attribute", 'hidden'
      assert_select "input#force[name=?][type=?]", "force", 'hidden'
    end
  end
end
