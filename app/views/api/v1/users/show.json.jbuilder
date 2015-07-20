json.user do
  if (@user != nil)
    json.(@user, :name, :register_date)#, @state)
  end
end
