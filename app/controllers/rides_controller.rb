class RidesController < ApplicationController

    def new
        @user = User.find_by(:id => params[:user_id])
        @message = @user.rides.build(:user_id => params[:user_id], :attraction_id => params[:attraction_id]).take_ride
        @attraction = Attraction.find_by(:id => params[:attraction_id])
            if @message == true
                flash[:notice] = "Thanks for riding the #{@attraction.name}!"
            else
                flash[:notice] = @message
            end
        redirect_to user_path(params[:user_id])
    end

end
