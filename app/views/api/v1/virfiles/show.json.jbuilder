json.if_file @if_file
json.frag_num @frag_num
#debugger
if @if_file
  json.frag_list do
    json.array! @frag_list do |frag|
      json.(frag, :addr, :index)
    end
  end
end
