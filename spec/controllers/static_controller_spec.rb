require 'spec_helper'

describe StaticController do

  describe "GET 'risk_report'" do
    it "assigns content as @content" do
      get 'risk_report'
      response.should be_success
      assigns(:content).should be_a_kind_of(Array)
      assigns(:content).first.should be_a_kind_of(Hash)
      assigns(:content).first[:title].should be
      assigns(:content).first[:content].should be_a_kind_of(Array)
      assigns(:content).first[:content].first.should be_a_kind_of(Hash)
      assigns(:content).first[:content].first[:content].should be
      assigns(:content).first[:content].first[:title].should be
    end
  end

  describe "GET 'efficiency'" do
    it "assigns indices as @indices" do
      get 'efficiency'
      response.should be_success
      assigns(:indices).should be_a_kind_of(Array)
      assigns(:indices).first.should be_a_kind_of(Array)
      assigns(:indices).first.size.should == 5
      assigns(:indices).first.first.should be_a_kind_of(String)
      (1..4).each do |i|
        assigns(:indices).first[i].should be_a_kind_of(Numeric)
      end
    end

    it "assigns throughput_params as @throughput_params" do
      get 'efficiency'
      response.should be_success
      assigns(:throughput_params).should be_a_kind_of(Array)
      assigns(:throughput_params).first.should be_a_kind_of(Array)
      assigns(:throughput_params).first.size.should == 5
      assigns(:throughput_params).first.first.should be_a_kind_of(String)
      (1..4).each do |i|
        assigns(:throughput_params).first[i].should be_a_kind_of(Numeric)
      end
    end
  end

end
