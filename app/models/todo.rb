class Todo < ApplicationRecord
  validates_presence_of :title, :due_date, :note

  def can_destroy?
    !overdue?
  end

  # 將判斷條件寫在 private method
  private
  def overdue?
    due_date < Date.today
  end
end
