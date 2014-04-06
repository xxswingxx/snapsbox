<% if !@buttons.last_page? %>
  length = $(".row.buttons-row").length
  $($(".row.buttons-row")[length-1]).after("<div class='row buttons-row'><%= escape_javascript(render(partial:'button', collection: @buttons)) %></div>");
  $('#next_page').html("<%= j(link_to_next_page(@buttons, 'Show more', remote: true, params: params, class: 'button')) %>");
<% else %>
  length = $(".row.buttons-row").length
  $($(".row.buttons-row")[length-1]).after("<div class='row buttons-row'><%= escape_javascript(render(partial:'button', collection: @buttons)) %></div>");
  $('#next_page_link').remove()
<% end %>      