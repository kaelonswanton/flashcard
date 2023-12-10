class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pagy, @decks = pagy(@user.decks, items: 10)  
  end
end
