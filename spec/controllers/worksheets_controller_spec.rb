require 'spec_helper'

describe WorksheetsController do
  describe "GET 'index'" do
    before(:each) do
      Worksheet.make! name: 'Demo', narrative: 'Bob starts a business...'
    end

    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should list the single worksheet" do
      get 'index'
      assigns(:worksheets).should have(1).worksheet
      worksheet = assigns(:worksheets).first
      worksheet.name.should == 'Demo'
      worksheet.narrative.should == 'Bob starts a business...'
    end
  end
end
