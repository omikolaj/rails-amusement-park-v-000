class User < ActiveRecord::Base
  # write associations here
  has_many :rides
  has_many :attractions, through: :rides

  #validates :name, :height, :happiness, :tickets, presence: true
  #validates :name, :height, :happiness, :tickets, uniqueness: true

  has_secure_password

  def mood
    self.nausea > self.happiness ? "sad" : "happy"
  end

end
