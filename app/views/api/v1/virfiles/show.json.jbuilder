json.if_file @if_file
json.frag_num @frag_num
#debugger
if @if_file
  
  json.file_sha1 @file_sha1
  json.file_md5 @file_md5
  json.frag_list do
    json.array! @frag_list do |frag|
      json.(frag, :addr, :index, :sha1, :md5, :server_name)
    end
  end
end
