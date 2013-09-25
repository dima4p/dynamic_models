require 'spec_helper'

describe StaticController do

  describe "GET 'risk_report'" do
    it "returns http success" do
      get 'risk_report'
      response.should be_success
    end
  end

  describe "GET 'efficiency'" do
    it "returns http success" do
      get 'efficiency'
      response.should be_success
    end
  end

end
