module PutTime
    #以下extendは必須
    extend ActiveSupport::Concern

    def print_day(day)
        require "date"
        return day.strftime('%m').to_i.to_s, day.strftime('%d').to_i.to_s
    end

end