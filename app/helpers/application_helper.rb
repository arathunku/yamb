module ApplicationHelper
  def is_active(controller, action)
    if params[:controller] == controller && params[:action] == action
      "active"
    else
      "inactive"
    end
  end

end
