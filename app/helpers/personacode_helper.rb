module PersonacodeHelper
  def include_persona_javascript
    "<script src=\"https://login.persona.org/include.js\"></script>".html_safe
  end

  def persona_signin_on_element(elem)
    "<script type=\"text/javascript\">
        $('##{elem}').bind('click', function() { navigator.id.request(); });
     </script>
    ".html_safe
  end

  def persona_signout_on_element(elem)
    "<script type=\"text/javascript\">
        $('##{elem}').bind('click', function() { navigator.id.logout(); });
    </script>
    ".html_safe
  end
#document.addEventListener('page:receive', function)
  def persona_handle_callbacks(params)
    "<script type=\"text/javascript\">
    $(document).ready(function() {
      navigator.id.watch({
      loggedInUser: #{current_user ? "'"+current_user.email+"'" : "null" },
      onlogin: function(assertion) {
        $.ajax({
          type: 'POST',
          url: '#{params[:login]}',
          data: {assertion: assertion},
          success: function(res, status, xhr) { window.location.href=\"#{params[:logged_in]}\"; },
          error: function(res, status, xhr) { alert(\"login failure\" + res); }
        });
      },
      onlogout: function() {
        $.ajax({
          type: 'POST',
          url: '#{params[:logout]}',
          success: function(res, status, xhr) { window.location.href=\"#{params[:logged_out]}\"; },
          error: function(res, status, xhr) { alert(\"logout failure\" + res); }
        });
      }
    });});
    </script>".html_safe
  end
end