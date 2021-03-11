class TimeTable < ApplicationRecord
    has_many :events
    has_many :event_joins, dependent: :destroy
end
