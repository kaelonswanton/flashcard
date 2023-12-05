class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @decks = @user.decks
  end
end
