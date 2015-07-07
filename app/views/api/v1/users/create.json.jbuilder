json.user do
  if (@user != nil)
    json.(@user, :id, :name, :register_date, :root_id)#, @state)
  end
  json.state(@state)
  #json.(@user, :id, :name)
end
