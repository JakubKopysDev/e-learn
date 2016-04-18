class UsersController < ApplicationController
before_action :find_user, only: [:show, :dashboard]
before_action :find_guides, only: [:show, :dashboard]
before_action :authenticate_user!, only: [:dashboard]
before_filter :verify_is_admin, only: [:index]
autocomplete :guide, :title, :full => true

  def show
    @user = User.find(params[:id])
    @guides = @user.guides.all.order('created_at DESC').page(params[:page])
  end

  def dashboard

    if params[:search]
      unless /^ +/.match(params[:search]) || /%+/.match(params[:search]) || params[:search].length < 3
        @guides = Guide.where(['description LIKE :search OR title LIKE :search', search: "%#{params[:search]}%"]).order("created_at DESC").page(params[:page])
        if @guides.count == 0
          flash[:notice] = "No guides found."
          redirect_to :back
        end
      else
        flash[:notice] = "Phrase must be minimum 4 letter long."
        redirect_to :back
      end
    else
      @guides = Guide.all.order("created_at DESC").page(params[:page])
    end

  end

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete
    redirect_to 'back'
  end

  private

    def find_user
      if params[:id].nil?
        @user = current_user
      else
        @user = User.find(params[:id])
      end
    end

    def find_guides
      @guides = Guide.where(user_id: @user).order("created_at DESC")
    end

    def verify_is_admin
      unless current_user.admin?
        redirect_to root_path
        flash[:danger] = "You need to be admin to proceed there."
      end
    end

end
