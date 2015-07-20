json.login_suc @flag

json.user do
  if (@user != nil)
    json.(@user, :name, :register_date, :authen_token)
  end
end

