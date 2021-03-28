class EventsController < InheritedResources::Base

  include PutTime

  def top
    @events = Event.order(date: :asc).limit(5)
  end

  def greeting
  end

  def index
    @events = Event.order(date: :asc).limit(30)
    today = time_part[:today]
    week = time_part[:week]

    # future > past
    @events_after = @events.where("date < ?", today)
    @events_before = @events.where("date >= ?", today)
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time_id, :recommend_menu, :recommend_menu_price, :place, :max_num, :comment, :store_url, :image)
  end

end
