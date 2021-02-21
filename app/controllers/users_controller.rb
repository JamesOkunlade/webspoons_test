class UsersController < ApplicationController
    before_action :set_user, only: %i[destroy edit update]

    respond_to :html

    def index
      if params[:search].blank?
        @users = User.all.paginate(page: params[:page], per_page: 25).order('created_at desc')
      else
        @parameter = params[:search].downcase
        @users = User.all.where("lower(name) LIKE :search", search: "%#{@parameter}%").paginate(
                  page: params[:page], per_page: 25).order('created_at desc')
      end
    end

    def new
        @user = User.new
        respond_modal_with @user
    end

    def create
        @user = User.create(user_params)
        respond_modal_with @user, location: users_path
        # respond_to do |format|
        #   if @user.save
        #     format.html { redirect_to users_path }
        #   else
        #     format.html { redirect_to users_path }
        #   end
        # end
    end

    def edit
      respond_modal_with @user
    end

    def update
        @user.update(user_params)
        respond_modal_with @user, location: users_path
        # respond_to do |format|
        #     if @user.update(user_params)
        #       format.html { redirect_to users_path, notice: 'User successfully updated' }
        #     else
        #       format.html { redirect_to users_path }
        #     end
        # end
    end

    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_path, notice: 'User deleted' }
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:name, :email, :title, :phone, :status)
    end
end
