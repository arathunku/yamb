module ApplicationHelper
  def is_active(controller, action)
    if params[:controller] == controller && params[:action] == action
      "active"
    else
      nil
    end
  end

end
