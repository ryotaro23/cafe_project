class EventsController < InheritedResources::Base

  include PutTime

  def top
    @events = Event.order(created_at: :desc).limit(5)
  end

  def greeting
  end

  def index
    @events = Event.order(created_at: :desc).limit(5)
    @event = @events[0].created_at
    @month, @day = print_day(@event)
  end

  private

  def event_params
    params.require(:event).permit(:name, :date, :time_id, :recommend_menu, :recommend_menu_price, :place, :max_num, :comment, :store_url, :image)
  end

end
