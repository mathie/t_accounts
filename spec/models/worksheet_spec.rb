require 'spec_helper'

describe Worksheet do
  describe "validations" do
    it "should require a name" do
      Worksheet.make(name: '').should_not be_valid
    end

    it "should require a narrative" do
      Worksheet.make(narrative: '').should_not be_valid
    end
  end
end
