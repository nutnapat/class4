class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :loged_in , except: %i[ login checklog new create]
  
  def loged_in
    if(session[:user_id].to_s==params[:id])
      return true
    else
      redirect_to main_path , notice: "Please login"
    end
  end

  def login
    session[:user_id] = nil

  end

  def checklog
    @email=params[:email]
    @pass=params[:password]
    @user = User.find_by({email:@email})
    if @user.present? && @user.authenticate(@pass)
      redirect_to user_path(User.find_by({email:@email}).id) , notice: "login successfully"
      session[:user_id]=User.find_by({email:@email}).id
    else
      render:wrong
    end
  end

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    
    
  end

  def create_fast
    @user=User.create(name:params[:name],email:params[:email],password:params[:password])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
      @posts = @user.posts
    end

    # Only allow a list of trusted parameters through.
    def user_params 
      params.require(:user).permit(:email,:password, :name, :bday,:address,:postal_code)
    end
end
