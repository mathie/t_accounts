require 'spec_helper'

describe ApplicationHelper do
  describe "markdown" do
    it "generates some basic HTML from markdown" do
      helper.markdown('Hello world.').should == <<-HTML
<p>Hello world.</p>
      HTML
    end

    it "emits html-safe strings" do
      helper.markdown('I am HTML-safe').should be_html_safe
    end

    it "defuses evil markup" do
      helper.markdown('I have <strong>evil</strong> markup.').should == <<-HTML
<p>I have &lt;strong>evil&lt;/strong> markup.</p>
      HTML
    end
  end
end
