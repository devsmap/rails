class Employee < ActiveRecord::Base

  ##############################################################################
  # Role
  ##############################################################################  
  extend Enumerize
  enumerize :role, in: { master: 1, support: 3, salesman: 5 }, predicates: true

  ##############################################################################
  # Validates
  ##############################################################################    
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :email, :role, presence: true
  validates :email, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }

  ##############################################################################
  # Devise
  # Include default devise modules. Others available are:
  # https://github.com/heartcombo/devise  
  ##############################################################################  
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  # def update_without_password(params, *options)
  #   if params[:password].blank?
  #     params.delete(:password)
  #     params.delete(:password_confirmation) if params[:password_confirmation].blank?
  #   end
    
  #   clean_up_passwords
  #   update(params, *options)
  # end  

end
