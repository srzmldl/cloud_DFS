json.if_file @if_file
json.frag_num @frg_num

json.frag_list do
  json.array! @a do |frag|
    json.(frag, :addr)
  end
end
