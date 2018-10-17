class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  after_create:create_cart

         has_many :reviews, dependent: :destroy
         has_one :post
         has_many :carts, dependent: :destroy


   acts_as_paranoid

		  validates_presence_of   :email
		  #validates_uniqueness_of :email, allow_blank: true, if: :email_changed?
		 # validates_format_of     :email, with: email_regexp
		  validates_presence_of     :password
		  validates_confirmation_of :password
		  validates :password,
		  length: { minimum: 6, maximum: 128 }

	validates :email, uniqueness_without_deleted: true, allow_blank: true, if: :email_changed?
	has_many :favorites, dependent: :destroy


end
