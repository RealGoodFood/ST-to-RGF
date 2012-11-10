require 'spec_helper'

describe "swap_items/new" do
  before(:each) do
    assign(:swap_item, stub_model(SwapItem).as_new_record)
  end

  it "renders new swap_item form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => swap_items_path, :method => "post" do
    end
  end
end
