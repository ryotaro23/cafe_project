class Event < ApplicationRecord
    # 写真を添付できる許可
    has_one_attached :image
end
