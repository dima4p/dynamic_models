require 'spec_helper'

describe "models/new" do
  it "renders new model form" do
    render

    # rendered.should == ''
    assert_select "form[action=?][method=?][enctype=?]",
        models_path, "post", 'multipart/form-data' do
      assert_select "input#file[name=?]", "file"
    end
  end
end
