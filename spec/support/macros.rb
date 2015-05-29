# Extraction not only about shared code but also centerlize the code
def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end