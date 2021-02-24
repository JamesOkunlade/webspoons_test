class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_user, only: %i[destroy edit update]

    def index
      if params[:search].blank?
        @users = User.all.order(sort_column + " " + sort_direction).paginate(:per_page => 25, :page => params[:page])
      else
        @parameter = params[:search].downcase
        @users = User.all.where("lower(name) LIKE :search", search: "%#{@parameter}%").order(sort_column + " " + sort_direction).paginate(
                    page: params[:page], per_page: 25)
      end
      @user = User.new
    end

    def new
        @user = User.new
        respond_to do |format|
          format.html
          format.js
        end
    end

    def create 
      index
      @user = User.new(user_params)
        respond_to do |format|
          if @user.save
            format.html { redirect_to users_path }
            format.js
          else
            format.html { redirect_to users_path }
          end
      end
    end

    def edit
    end

    def update
        @user.update(user_params)
        respond_to do |format|
            if @user.update(user_params)
              index
              format.html { redirect_to users_path, notice: 'User successfully updated' }
              format.js
            else
              format.html { redirect_to users_path }
            end
        end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_path, notice: 'User deleted' }
            # format.js
        end
    end

    private

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :title, :phone, :status)
    end
end
