require 'spec_helper'

describe "models/index" do
  before(:each) do
    assign(:table_names, %w[examples more_examples])
  end

  it "renders a list of models" do
    render
    # rendered.should == ''

    assert_select "tr>td", :text => "Example", :count => 1
    assert_select "tr>td", :text => "MoreExample", :count => 1
  end
end
