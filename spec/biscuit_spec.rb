require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Biscuit" do

  it "should give us a cookie!" do
    Biscuit.connect!
    cookie = Biscuit::Cookie.first
    cookie.host_key.should_not be_nil
  end

end
