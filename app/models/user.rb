class User < ApplicationRecord
  has_many :books
  has_many :reviews
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_attached_file :profile_image, styles: { small_profile_image: "100x100>", large_profile_image: "300x300>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :profile_image, content_type: /\Aimage\/.*\z/
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
