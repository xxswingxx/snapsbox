$ ->
  $('input#selection_trigger').click (source) ->
    checkboxes = $('table.bookmarks input[name^=selection]')
    box.checked = source.target.checked for box in checkboxes