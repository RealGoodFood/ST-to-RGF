require 'spec_helper'

describe "swap_items/edit" do
  before(:each) do
    @swap_item = assign(:swap_item, stub_model(SwapItem))
  end

  it "renders the edit swap_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => swap_items_path(@swap_item), :method => "post" do
    end
  end
end
