class LikesController < ApplicationController

    def create
        @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
        @like.save
        redirect_to("/posts/#{params[:post_id]}")
        flash[:notice] = "good!しました。"
    end

    def destroy
        @like = Like.find_by(user_id: @current_user.id,post_id: params[:post_id])
        @like.destroy
        redirect_to("/posts/#{params[:post_id]}")
        flash[:notice] = "good!を取り消しました。"
    end

end