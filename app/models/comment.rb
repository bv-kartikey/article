class Comment < ApplicationRecord


  #validations
  validates :body, presence:true
  

  #relations
  
  belongs_to :post
  belongs_to :user

end
