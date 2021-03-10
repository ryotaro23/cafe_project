require 'rails_helper'

RSpec.describe "events/edit", type: :view do
  before(:each) do
    @event = assign(:event, Event.create!(
      name: "MyString",
      time_id: 1,
      recommend_menu: "MyText",
      place: "MyText",
      max_num: 1
    ))
  end

  it "renders the edit event form" do
    render

    assert_select "form[action=?][method=?]", event_path(@event), "post" do

      assert_select "input[name=?]", "event[name]"

      assert_select "input[name=?]", "event[time_id]"

      assert_select "textarea[name=?]", "event[recommend_menu]"

      assert_select "textarea[name=?]", "event[place]"

      assert_select "input[name=?]", "event[max_num]"
    end
  end
end
