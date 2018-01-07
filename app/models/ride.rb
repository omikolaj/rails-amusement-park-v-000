class Ride < ActiveRecord::Base
  # write associations here
  belongs_to :user
  belongs_to :attraction

  def take_ride
    if can_user_take_a_ride?
      update_user_tickets && update_user_nausea && update_user_happiness
    else
      notify_user
    end
  end

  def notify_user
    @message    
  end

  def can_user_take_a_ride?
    @message = ""
    met_req = true
    if self.user.height < self.attraction.min_height && self.user.tickets < self.attraction.tickets
      @message = "Sorry. You do not have enough tickets to ride the #{attraction.name}. You are not tall enough to ride the #{attraction.name}."
      met_req = false
    elsif self.user.height < self.attraction.min_height
      @message = "Sorry. You are not tall enough to ride the #{attraction.name}."
      met_req = false
    elsif self.user.tickets < self.attraction.tickets
      @message = "Sorry. You do not have enough tickets to ride the #{attraction.name}."
      met_req = false
    end
    met_req
  end

  def self.update_user(*args)
    methods = args.map{|i| i.to_s}
    methods.each do |method_name|
      define_method "update_user_#{method_name}" do
        if method_name == "tickets"
          #argument = self.user.send("#{method_name}") - self.attraction.send("#{method_name}")
          self.user.update(:"#{method_name}" => self.user.send("#{method_name}") - self.attraction.send("#{method_name}"))
        else
          #argument = self.user.send("#{method_name}") + self.attraction.send("#{method_name}_rating")
          self.user.update(:"#{method_name}" => self.user.send("#{method_name}") + self.attraction.send("#{method_name}_rating"))
        end
      end
    end
  end

  update_user :tickets, :nausea, :happiness



=begin
  def update_user_tickets
    user_tickets = self.user.tickets - self.attraction.tickets
    self.user.update(:tickets => user_tickets)
  end

  def update_user_nausea
    user_nausea = self.user.nausea + self.attraction.nausea_rating
    self.user.update(:nausea => user_nausea)
  end

  def update_user_happiness
    user_happiness = self.user.happiness + self.attraction.happiness_rating
    self.user.update(:happiness => user_happiness)
  end
=end


end
