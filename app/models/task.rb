class Task < ApplicationRecord
    validates :name, presence: true
    validates :content, presence: true

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
    #def self.seach
      #if params[:seach][:status].present? && params[:seach][name].present?
        #@tasks = @tasks.where('name LIKE ? AND status LIKE?', "%#{params[:search]}%")
      #elsif params[:seach][:status].present?
        #@tasks = @tasks.where(status: params[:status])
      #else
        #@tasks = @tasks.where('name LIKE ?', "%#{params[:search]}%")
      #end
    #end     
end
