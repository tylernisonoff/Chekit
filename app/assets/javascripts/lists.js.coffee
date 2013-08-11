# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $(".list").click ->
    id = getId(this)
    $.ajax '/lists/'+id,
      type: 'GET'
      error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call: #{data}"
          for item in data
            addItem item


addItem = (item) ->
  console.log(item.name)
  $("#item-list").append(buildDiv(item))
 
buildDiv = (item) ->
  "<div class='item' id='item#{item.id}'>"+
    "<div class='display'>"+
      "<input type='checkbox' class='check' name='markdone'>"+
      "<div class='item-text'>#{item.name}"+
      "</div>"+
    "</div>"+
    "<div class='item-tags'>"+
      "<div class='tag addtag'>"+
        "+tag"+
      "</div>"+
    "</div>"+
  "</div>"
getId = (list) ->
  list.id.substring(4)


