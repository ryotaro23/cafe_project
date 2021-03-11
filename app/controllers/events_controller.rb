class EventsController < InheritedResources::Base

  def top
    @events = Event.order(created_at: :desc).limit(5)
  end
  private

    def event_params
      params.require(:event).permit(:name, :time_id, :recommend_menu, :place, :max_num, :image)
    end

end
