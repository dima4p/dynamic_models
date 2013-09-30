# Place all the behaviors and hooks related to the StaticController here.

radius = 42
canvas = 130
center_x = canvas / 2
center_y = canvas / 2 + 12

arc = (value, total, color) ->
  alpha = 360 / total * value
  a = (90 - alpha) * Math.PI / 180
  x = center_x + radius * Math.cos(a)
  y = center_y - radius * Math.sin(a)
  if total == value
    path = [["M", center_x, center_y - radius]
            ["A", radius, radius, 0, 1, 1, center_x - 0.01, center_y - radius]]
  else
    path = [["M", center_x, center_y - radius]
            ["A", radius, radius, 0, +(alpha > 180), 1, x, y]]
  {
    path: path
    stroke: color
  }
draw_arcs = ->
  if $('body.static.efficiency').length
    graphs = $('.graph')
    color = graphs.css('color')
    param = {"stroke-width": 10}
    graphs.each ->
      r = Raphael(this, canvas, canvas)
      r.customAttributes.arc = arc
      r.path().attr(param).attr({arc: [10, 10, color]})
      if val = parseInt $(this).find('.number').html()
        total = parseInt $(this).data('maximum')
        c = $(this).css 'color'
        r.path().attr(param).attr({arc: [val, total, c]})

$ draw_arcs
$(document).on 'page:load', draw_arcs
$(document).on 'change', 'body.static.risk_report input[type=checkbox]', ->
  label = $(this).prev()
  label.removeClass 'on off'
  if this.checked
    label.addClass 'on'
  else
    label.addClass 'off'
