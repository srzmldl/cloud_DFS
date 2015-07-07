json.user do
  json.(@user, :id, :name, :register_date, :root_id)#, @state)
  json.state(@state)
  #json.(@user, :id, :name)
end
