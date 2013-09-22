require 'spec_helper'

describe "proxies/show" do
  before(:each) do
    Proxy.table_name = 'examples'
    assign(:table_name, 'examples')
    @proxy = assign(:proxy, stub_model(Proxy, name: 'Proxy', position: 5))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/Proxy/)
    rendered.should match(/5/)
  end
end
