class AuthorizationsController < ApplicationController

  def login
    if params[:assertion].nil?
      head :bad_request
      flash[:warning] = "Assertion is nil, everything is ok?"
    else
      json_from_persona = authenticate_with_persona(params.slice(:assertion).merge(audience: 'localhost'))
      if json_from_persona['status'] == "okay"
        flash[:success] = "Successfully authorized"
        email = json_from_persona["email"]
        @user = User.find_or_initialize_by(email: email)
        if @user.save
          sign_in @user
        else
          flash[:error] = @user.errors.full_messages
          redirect_to root_path
        end
      else
        flash[:warning] = "Something went terribly wrong altough service answered"
        head :bad_request
      end
    end
  end

  def logout
    sign_out
    flash[:notice] = "Logged out successfuly"
  end

  def optout
    current_user.destroy
    sign_out
    redirect_to root_path
  end
end
