class EventsController < InheritedResources::Base

  private

    def event_params
      params.require(:event).permit(:name, :time_id, :recommend_menu, :place, :max_num, :image)
    end

end
