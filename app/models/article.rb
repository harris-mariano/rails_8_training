class Article < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user

  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :user, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "title" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "comments", "user" ]
  end
end
