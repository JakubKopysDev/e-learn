require 'will_paginate/array'

class GuidesController < ApplicationController
before_filter :require_permition, except: [:show, :up_vote, :down_vote, :unvote]
before_action :find_user
before_action :find_guide, only: [:show, :edit, :destroy, :update]
before_action :authenticate_user!, except: [:show]
autocomplete :guide, :title, :full => true

  def new
    @guide = @user.guides.new
  end

  def create
    @guide = @user.guides.new guide_params
    if @guide.save
      redirect_to user_guide_path(@user, @guide)
    else
      render 'new'
    end
  end

  def show
    @guides = Guide.where(user_id: @user).order("created_at DESC").reject{ |e| e.id == @guide.id}.paginate(:page => params[:page], per_page: 10)
  end

  def destroy
    @guide.delete
    redirect_to :back
  end

  def edit
  end

  def update
    if @guide.update guide_params
      redirect_to user_guide_path(@user, @guide), notice: "Episode successfully updated"
    else
      render 'edit'
    end
  end

  def up_vote
    @user = current_user
    @guide = Guide.find(params[:id])

    if vote = Vote.find_by(user_id: @user.id, guide_id: @guide.id)
      if (vote.up_vote == true)
        redirect_to :back
      else
        vote.up_vote = true
        vote.save
        @guide.down_votes -= 1
        @guide.up_votes += 1
        @guide.save
        respond_to do |format|
          format.html {
            flash[:notice] = "Vote changed!"
            redirect_to :back
          }
          format.js
        end
      end
    else
      Vote.create(user_id: @user.id, guide_id: @guide.id, up_vote: true)
      @guide.up_votes += 1
      @guide.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Upvoted!"
          redirect_to :back
        }
        format.js
      end
    end
  end

    def down_vote
    @user = current_user
    @guide = Guide.find(params[:id])

    if vote = Vote.find_by(user_id: @user.id, guide_id: @guide.id)
      unless vote.up_vote
        redirect_to :back
      else
        vote.up_vote = false
        vote.save
        @guide.down_votes += 1
        @guide.up_votes -= 1
        @guide.save
        respond_to do |format|
          format.html {
            flash[:notice] = "Vote changed!"
            redirect_to :back
          }
          format.js
        end
      end
    else
      Vote.create(user_id: @user.id, guide_id: @guide.id, up_vote: false)
      @guide.down_votes += 1
      @guide.save
      respond_to do |format|
        format.html {
          flash[:notice] = "Vote changed!"
          redirect_to :back
        }
        format.js
      end
    end
  end

  def unvote

    @user = current_user
    @guide = Guide.find(params[:id])

    vote = Vote.find_by(user_id: @user.id, guide_id: @guide.id)

    if vote.up_vote
      @guide.up_votes -= 1
      respond_to do |format|
        format.html {
          flash[:notice] = "Upvote cancelled!"
          redirect_to :back
        }
        format.js
      end
    else
      @guide.down_votes -= 1
      respond_to do |format|
        format.html {
          flash[:notice] = "Downvote cancelled!"
          redirect_to :back
        }
        format.js
      end
    end

    @guide.save
    vote.destroy

  end

  private

    def guide_params
      params.require(:guide).permit(:title, :description, :thumbnail, :video)
    end

    def find_user
      @user = User.find(params[:user_id])
    end

    def find_guide
      @guide = Guide.find(params[:id])
    end

    def require_permition
      @user = User.find(params[:user_id])
      if ((current_user != @user) && !current_user.admin?)
        redirect_to root_path, notice: "Sorry, you're not allowed to view this page"
      end
    end

end
