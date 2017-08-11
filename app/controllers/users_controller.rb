class UsersController < ApplicationController
  
  # GET /users/get_me
  def get_me
    @user = AuthorizeController.authorize(request)
    render json: @user
  end

  # POST /users/create
  def create
    if create_user
        if params[:user_type] == 'professional'
            @prof = Professional.new(professional_params)
            change_professional

            if @prof.save
                render json: @user, except: :password
            else
                render json: @prof.errors, status: :unprocessable_entity
            end
        else
            @client = Client.new
            change_client

            if @client.save
                render json: @user, except: :password
            else
                render json: @prof.errors, status: :unprocessable_entity
            end
        end
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PUT /users/update
  def update
    @user = AuthorizeController.authorize(request)
    if @user.update(user_update_params)
        if @user.user_type == 'professional'
            @prof = @user.professional
            change_professional
            
            if @prof.update(professional_params)
                render json: @user, except: :password
            else
                render json: @prof.errors, status: :unprocessable_entity
            end
        else
            #client has no fields, doesnt need to change
            render json: @user, except: :passwords
        end
    else
        render json: @user.errors, status: :unprocessable_entity
    end
  end

private

  def user_create_params
    params.permit(:email, :password, :name, :date_of_birth, :user_type)
  end

  def user_update_params
    params.permit(:email, :password, :name, :date_of_birth)
  end

  def professional_params
    params.require(:professional).permit(:address, :phone, :description)
  end

  def create_user
    @user = User.new(user_create_params)

    if params[:gender]
        @user.gender = Gender.find_by(params[:gender])
    end
    
    if params[:image]
        image = Image.new(base64: params[:image])
        @user.image = image
    end

    return @user.save
  end

  def change_client
    @client.user = @user
  end

  def change_professional
    @prof.user = @user
    if params[:diploma]
        diploma = Image.new(base64: params[:diploma])
        @prof.diploma = diploma
    end

    if params[:background]
        background = Image.new(base64: params[:background])
        @prof.background = background
    end
  end
end
