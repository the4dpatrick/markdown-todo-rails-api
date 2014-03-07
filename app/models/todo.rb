class Todo < ActiveRecord::Base
  after_initialize :default_values

  belongs_to :list
  validates :item, presence: true

  private

  def default_values
    self.completed ||= false
  end
end
