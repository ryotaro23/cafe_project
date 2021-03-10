require 'rails_helper'

RSpec.describe "events/new", type: :view do
  before(:each) do
    assign(:event, Event.new(
      name: "MyString",
      time_id: 1,
      recommend_menu: "MyText",
      place: "MyText",
      max_num: 1
    ))
  end

  it "renders new event form" do
    render

    assert_select "form[action=?][method=?]", events_path, "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[time_id]"

      assert_select "textarea[name=?]", "event[recommend_menu]"

      assert_select "textarea[name=?]", "event[place]"

      assert_select "input[name=?]", "event[max_num]"
    end
  end
end
