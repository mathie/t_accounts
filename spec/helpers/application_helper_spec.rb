require 'spec_helper'

describe ApplicationHelper do
  describe "markdown" do
    it "generates some basic HTML from markdown" do
      helper.markdown('Hello world.').should == <<-HTML
<p>Hello world.</p>
      HTML
    end
  end
end
