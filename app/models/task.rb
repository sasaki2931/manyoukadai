class Task < ApplicationRecord
    validates :name, presence: true
    validates :content, presence: true

    belongs_to :user

    has_many :labellings, dependent: :destroy
    has_many :labels, through: :labellings

    enum status: { 未着手: 0,着手中: 1,完了: 2,}
    enum rank: {高: 0,中: 1,低: 2}

    scope :name_seach,->(name) {
        return if name.blank?
        where('name LIKE ?',"%#{name}%") 
    }

    scope :status_seach,->(status) {
        return if status.blank?
        where(status: status)
    }
end
