json.array!(@proxies) do |proxy|
  json.extract! proxy, 
  json.url proxy_url(proxy, table_name: @table_name, format: :json)
end
