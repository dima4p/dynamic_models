require 'spec_helper'

describe "models/show" do
  before(:each) do
    assign(:table_name, 'examples')
    assign(:columns, name: 'string', position: 'integer')
  end

  it "renders list of attributes of the table" do
    render
    rendered.should match(/name/)
    rendered.should match(/string/)
    rendered.should match(/position/)
    rendered.should match(/integer/)
  end
end
