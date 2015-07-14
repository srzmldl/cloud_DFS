json.list do
  json.array! @index_list do |virfiles|
    json.(virfiles, :id, :name)
    if (virfiles.phys_id < 0)
      json.if_file(0)
    else json.if_file(1)
    end
  end
end
