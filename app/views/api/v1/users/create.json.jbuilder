json.state @state
json.user do
  if (@user != nil)
    json.(@user, :name, :register_date, :authen_token)#, @state)
  end
end
