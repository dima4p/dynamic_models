# Place all the behaviors and hooks related to the ProxiesController here.

$ ->

  if $('body.proxies').length
    # console.log 'body.proxies'
    close_inputs = (i)->
      rows = $('table tr:not(:first-of-type)')
      rows.each ->
        td = $(this).find('td').eq(i)
        $(this).removeClass('updated')
        td.find('input').autocomplete( "destroy" )
        td.html td.find('input').attr('value') if td.find('input').length
      $('.columns_control').hide()
      $.fn.open_comumn = -1
      $('#force').val('')
    send_column_update_request = ->
      form = $('form')
      $.post form.attr('action'), form.serialize(), ((data)->
        data = eval(data)
        if data.length
          rows = $('table tr:not(:first-of-type)')
          rows.each ->
            id = parseInt($(this).find('td').eq(-1).find('a').attr('href').split(/\//).pop())
            if data.indexOf(id) >= 0
              $(this).addClass('updated')
          $('.first_save').hide()
          $('.force_save_columns').show()
        else
          window.location = form.attr('action').split(/\//).slice(0,-1).join('/')
      ), 'script'
    # Open form
    $(document).on 'click', 'table tr:first-of-type th[column_name]', ->
      i = $(this).index()
      return if i == $.fn.open_comumn
      close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
      attribute = $(this).attr 'column_name'
      $('#attribute').val(attribute)
      rows = $(this).closest('table').find('tr:not(:first-of-type)')
      width = rows.eq(0).find('td').eq(i).css('width')
      values = $.makeArray(rows.map ->
        $(this).find('td').eq(i).html())
      rows.each ->
        id = $(this).find('td').eq(-1).find('a').attr('href').split(/\//).pop()
        td = $(this).find('td').eq(i)
        td.html '<input type="text" style="width:'+width+';" name="'+attribute+'['+id+']" value="'+td.html()+'">'
        td.find('input').autocomplete
          source: values
          minLength: 0
      $('.save_columns').show()
      $.fn.open_comumn = i
    $(document).on 'click', '.cancel', ->
      close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
      false
    $(document).on 'click', '.show', ->
      close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
      true
    $(document).on 'click', '.edit', ->
      close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
      true
    $(document).on 'click', '.new', ->
      close_inputs($.fn.open_comumn) if $.fn.open_comumn >= 0
      true
    $(document).on 'click', '.first_save', ->
      send_column_update_request()
      false
    $(document).on 'click', '.force_save_columns', ->
      $('#force').val('1')
      send_column_update_request()
      false
