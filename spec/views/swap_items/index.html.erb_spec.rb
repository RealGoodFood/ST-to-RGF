require 'spec_helper'

describe "swap_items/index" do
  before(:each) do
    assign(:swap_items, [
      stub_model(SwapItem),
      stub_model(SwapItem)
    ])
  end

  it "renders a list of swap_items" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
