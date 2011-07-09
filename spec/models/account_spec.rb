require 'spec_helper'

describe Account do
  describe "Padding the code" do
    it "should 0-pad a code" do
      account = Account.make(:code => '003')
      account.code.should == '003'

      account = Account.make(:code => '3')
      account.code.should == '003'
    end

    it "should not asplode while 0-padding an invalid code" do
      lambda {
        account = Account.make(:code => 'chickens')
      }.should_not raise_error
    end
  end
end
