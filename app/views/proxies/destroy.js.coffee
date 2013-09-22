url = '<%= proxy_path @proxy.id, table_name: @table_name %>'
line = $("a[href='#{url}']").closest('tr')
line.fadeOut 500, ->
  line.remove()
