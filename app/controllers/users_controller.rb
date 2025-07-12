class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token

    #Creating a new User
    def create
        @user = User.create(
            full_name: params[:full_name],
            email: params[:email],
            password: params[:password]
        )
        
        if @user.save
            render json: { message: "User created successfully", user: @user }, status: :created
        else
            render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
    end

    #function for login in which a session id will create 
    def login
        # user = User.find_by([email: params[:email]])
        user = User.find_by(email: params[:email], password: params[:password])
        if user
            token = SecureRandom.hex(16)
            user.update(session_id: token)
            render json: { token: token, user: user }
        else
            render json: { error: "Invalid email or password" }, status: :unauthorized
        end
    end

    #Show all Users
    def getAllUser
        @users = User.all 

        render json:@users
    end

    #Update User
    def update
        user = User.find_by(id: params[:id])

        if user&.update(full_name: params[:full_name], email: params[:email], password: params[:password])
            render json: { message: "User updated successfully", user: user }
        else
            render json: { error: user&.errors&.full_messages || "User not found" }, status: :unprocessable_entity
        end
    end

    #Delete User
    def delete
        user = User.find_by(id: params[:id])

        if user&.destroy()  
            render json: { message: "User deleted successfully", user: user }
        else
            render json: { error: user&.errors&.full_messages || "User not found" }, status: :unprocessable_entity
        end
    end

end
