# frozen_string_literal: true

# Used for logging in
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :validatable,
         :trackable, :validatable, :timeoutable
end
