json.frag_list do
  json.array! @a do |frag|
    json.(frag, :addr)
  end
  json.if_file(@if_file)
  json.frag_num(@frg_num)
end
