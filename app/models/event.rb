class Event < ApplicationRecord
    # 写真を添付できる許可
    has_one_attached :image
    has_many :event_joins, dependent: :destroy
    belongs_to :time_table, foreign_key: "time_id"

    def join_by?(user)
        event_joins.where(user_id: user.id).exists?
    end
end
