class Post < ApplicationRecord

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :body, presence: true, length: {minimum: 10 }
  has_many :comments, dependent: :destroy
  belongs_to :user

end
