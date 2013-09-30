require 'spec_helper'

describe "static/risk_report" do
  before(:each) do
    assign(:content,
      [{title: 'Titile 1',
        content: [{title: 'Subtitle 1',
                   content: [
                             'paragraph 11'
                    ]},
                  {title: 'Subtitle 2',
                   content: 'paragraph 12'
                 }]},
        {title: 'Titile 3',
         content: [{content: %q(paragraph 31)}] }]
          )
  end

  it "renders content" do
    render
    # rendered.should == ''

    assert_select "div.division_title", :text => "Titile 1", :count => 1
    assert_select "div.chapters>div.chapter>div.chapter_title", :text => "Subtitle 1",
        :count => 1
    assert_select "div.chapters>div.chapter>p", :text => "paragraph 11", :count => 1
    assert_select "div.chapters>div.chapter>div.chapter_title", :text => "Subtitle 2",
        :count => 1
    assert_select "div.chapters>div.chapter>p", :text => "paragraph 12", :count => 1
    assert_select "div.division_title", :text => "Titile 3", :count => 1
    assert_select "div.chapters>div.chapter>p", :text => "paragraph 31", :count => 1
  end

  it "renders switches" do
    render
    # rendered.should == ''

    assert_select "input#most_resent[name=?][type=?]", "most_resent", 'checkbox'
    assert_select "input#most_risky[name=?][type=?]", "most_risky", 'checkbox'
  end
end
