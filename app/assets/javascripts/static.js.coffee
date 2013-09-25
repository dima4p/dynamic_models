# Place all the behaviors and hooks related to the StaticController here.

$ ->
  if $('body.static').length
    $(document).on 'change', 'body.static.risk_report input[type=checkbox]', ->
      label = $(this).prev()
      label.removeClass 'on off'
      if this.checked
        label.addClass 'on'
      else
        label.addClass 'off'
