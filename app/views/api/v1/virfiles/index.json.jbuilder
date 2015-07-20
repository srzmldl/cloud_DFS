json.list do
  json.array! @index_list do |virfiles|
    json.(virfiles, :name)
    if (virfiles.phys_id < 0)
      json.if_file(false)
    else json.if_file(true)
    end
  end
end
