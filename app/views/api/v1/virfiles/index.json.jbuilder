json.list do
  json.array! @a do |virfiles|
    json.(virfiles, :id, :name)
    if (vifriles.phys_id < 0)
      json.if_file(0)
    else json.if_file(1)
    end
  end
end
