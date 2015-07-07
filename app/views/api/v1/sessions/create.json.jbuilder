json.user do
  if (@user != nil)
    json.(@user, :id, :name, :register_date, :root_id)
  end
  json.flag(@flag)
end
