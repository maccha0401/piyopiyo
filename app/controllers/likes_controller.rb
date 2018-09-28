class LikesController < ApplicationController
  def create
    @like = Like.create(user_id: current_user.id, knowhow_id: params[:knowhow_id])
    @knowhow = Knowhow.find(params[:knowhow_id])
  end
  
  def destroy
    @like = Like.find(params[:id]).destroy
    @knowhow = Knowhow.find(@like.knowhow_id)
  end
end
