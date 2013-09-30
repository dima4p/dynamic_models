require 'spec_helper'

describe "static/efficiency" do
  before(:each) do
    assign(:indices, [
      ['accidents', 0, 0, 0, 1],
      ['emergencies', 0, 0, 0, 1],
      ['violations', 0, 5, 10, 17]
    ])
    assign(:throughput_params, [
      ['value_of_realization', 13, 5, 12, 100],
      ['value_of_realization', 594, 575, 558, 800]
     ])
  end

  it "renders content" do
    render
    # rendered.should == ''

    assert_select "div.data>div.datum>div.graph>div.number", :text => 0.to_s,
        :count => 7
    assert_select "div.data>div.datum>div.graph>div.number", :text => 5.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.graph>div.number", :text => 10.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.number", :text => 13.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.number", :text => 5.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.number", :text => 12.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.number", :text => 594.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.number", :text => 575.to_s,
        :count => 1
    assert_select "div.data>div.datum>div.number", :text => 558.to_s,
        :count => 1
  end
end
