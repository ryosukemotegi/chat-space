class Group < ApplicationRecord
  has_many :messages
  has_many :users, through: :user_groups
  has_many :user_groups
  accepts_nested_attributes_for :user_groups
  validates :name, presence: true

  def last_message
    messages.present? ? messages.last.body : 'メッセージがありません'
  end
end
