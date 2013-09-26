# Place all the behaviors and hooks related to the ProxiesController here.

$ ->

  # console.log 'body.proxies'
  close_inputs = (i)->
    rows = $('body.proxies table tr:not(:first-of-type)')
    rows.each ->
      td = $(this).find('td').eq(i)
      $(this).removeClass('updated')
      td.find('input').autocomplete( "destroy" )
      td.html td.find('input').attr('value') if td.find('input').length
    $('body.proxies .columns_control').hide()
    $.fn.open_comumn = -1
    $('body.proxies #force').val('')
  send_column_update_request = ->
    form = $('body.proxies form')
    $.post form.attr('action'), form.serialize(), ((data)->
      $.fn.updated = data = eval(data)
      if data.length
        rows = $('body.proxies table tr:not(:first-of-type)')
        rows.each ->
          id = parseInt($(this).find('td').eq(-1).find('a').attr('href').split(/\//).pop())
          if data.indexOf(id) >= 0
            $(this).addClass('updated')
        $('body.proxies .first_save').hide()
        $('body.proxies .force_save_columns').show()
      else
        window.location = form.attr('action').split(/\//).slice(0,-1).join('/')
    ), 'script'

  # Open form
  $(document).on 'click', 'body.proxies table tr:first-of-type th[column_name]', ->
    i = $(this).index()
    return if i == $.fn.open_comumn
    close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
    attribute = $(this).attr 'column_name'
    $('#attribute').val(attribute)
    rows = $(this).closest('table').find('tr:not(:first-of-type)')
    width = rows.eq(0).find('td').eq(i).css('width')
    values = $.makeArray($.unique(rows.map ->
      $(this).find('td').eq(i).html())).sort()
    rows.each ->
      id = $(this).find('td').eq(-1).find('a').attr('href').split(/\//).pop()
      td = $(this).find('td').eq(i)
      td.html '<input type="text" style="width:'+width+';" name="'+attribute+'['+id+']" value="'+td.html()+'">'
      td.find('input').autocomplete
        source: values
        minLength: 0
    $('.save_columns').show()
    $.fn.open_comumn = i
    $.fn.updated = []
  $(document).on 'click', 'body.proxies .cancel', ->
    if $.fn.updated.length
      window.location.reload(false)
    else
      close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
    false
  $(document).on 'click', 'body.proxies .show', ->
    close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
    true
  $(document).on 'click', 'body.proxies .edit', ->
    close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
    true
  $(document).on 'click', 'body.proxies .new', ->
    close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
    true
  $(document).on 'click', 'body.proxies .first_save', ->
    send_column_update_request()
    false
  $(document).on 'click', 'body.proxies .force_save_columns', ->
    $('#force').val('1')
    send_column_update_request()
    false
