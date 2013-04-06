class AuthorizationsController < ApplicationController

  def login
    #oh god, that method needs refactoring.
    if params[:assertion].nil?
      head :bad_request
      flash[:warning] = "Assertion is nil, everything is ok?"
    else
      json_from_persona = authenticate_with_persona(params.slice(:assertion).merge(audience: 'localhost'))
      if json_from_persona['status'] == "okay"
        flash[:success] = "Successfully authorized"
        email = json_from_persona["email"]
        @user = User.find_by(email: email)
        if @user 
          sign_in @user
          respond_to do |format|
            format.html { redirect_to settings_path }
            format.json { render :json => {:status => 'ok' } }
          end
          return
        end
        @user = User.new(email: email)
        if @user.save
          sign_in @user
          respond_to do |format|
            format.html { redirect_to settings_path }
            format.json   { render :json => {:status => 'ok' } }
          end
          return
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


  #logout is called without javascript. 
  #Turbolinks -> problem with binding after loading partial
  def logout
    sign_out
    flash[:notice] = "Logged out successfuly"
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json   { render :json => {:status => 'ok' } }
    end
  end

  def optout
    current_user.destroy
    sign_out
    redirect_to root_path
  end
end
