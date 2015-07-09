json.login_suc @flag

json.user do
  if (@user != nil)
    json.(@user, :id, :name, :register_date, :root_id)
    
  end
end

