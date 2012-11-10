require 'spec_helper'

describe "swap_items/show" do
  before(:each) do
    @swap_item = assign(:swap_item, stub_model(SwapItem))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
