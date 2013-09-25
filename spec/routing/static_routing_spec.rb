require "spec_helper"

describe StaticController do
  describe "routing" do

    it "routes to #risk_report" do
      get("static/risk_report").should route_to("static#risk_report")
    end

    it "routes to #efficiency" do
      get("static/efficiency").should route_to("static#efficiency")
    end

  end
end
