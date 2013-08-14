# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  # registering click event for list div
  $(document).on("click", ".list", -> 
    changeSelected(this)
    id = getId(this)
    getList(id))

  $(".list:first").click()
  # registering click event for add tag
  # makes edit div with input visibile
  # hides add tag
  # puts input in focus
  $(document).on("click", ".addtag", ->
    this.style.display = "none"
    editTag = $(this).prev()[0]
    editTag.style.display  = "inline"
    input = $(editTag).children()[0]
    $(input).focus()
  )
  
  # registering blur event for edittag
  # hides edit div with input
  # makes addTag div visible
  $(document).on("blur", ".edittag-input", ->
    hideEditAndShowAdd(this)
  )

  $(document).on("keyup", ".edittag-input", (e) ->
    if e.keyCode == 13
      itemId =  getItemIdFromEditTag(this)
      newTag = $(this).val()
      hideEditAndShowAdd(this) 
      postTag(itemId, newTag)
  )

  # creates a new list on enter in new list input
  $("#new-list").keyup (e) ->
    if e.keyCode == 13
      postList()
      $("#new-list").val("")

  # creates a new list on enter in new list input
  $("#new-todo").keyup (e) ->
    if e.keyCode == 13
      postItem()
      $("#new-todo").val("")

hideEditAndShowAdd = (input) ->
  $(input).val("")
  editDivToHide = $(input).parent()[0]
  editDivToHide.style.display = "none"
  addTag = $(editDivToHide).next()[0]
  addTag.style.display = "inline"

postTag = (itemId, newTag) ->
  $.ajax '/items/'+itemId+'/tag.js',
    type: 'POST',
    data: {"name": newTag }
    error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call"

postItem =  ->
  value = $("#new-todo").val()
  list_id = getListIdFromSelected()
  console.log(list_id)
  if /\S/.test value
    $.ajax '/items.js',
      type: 'POST',
      data: {"item": {"name" : value, "list_id" : list_id}},
      error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call"

postList =  ->
  value = $("#new-list").val()
  if /\S/.test value
    $.ajax '/lists.js',
      type: 'POST',
      data: {"list": {"name" : value}},
      error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}"
      success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call"

getList = (id) ->
  console.log id
  $.ajax '/lists/'+id+'.js',
      type: 'GET',
      error: (jqXHR, textStatus, errorThrown) ->
          console.log "AJAX Error: #{textStatus}, #{errorThrown}, #{jqXHR}"
          console.log jqXHR
      success: (data, textStatus, jqXHR) ->
          console.log "Successful AJAX call"

getItemIdFromEditTag = (edit) ->
  parentsArray = $(edit).parentsUntil("#item-list")
  item = parentsArray[parentsArray.length-1]
  id = $(item).attr('itemId')

getListIdFromSelected = () ->
  selectedList = $(".list.selected")[0]
  getId(selectedList)

getId = (list) ->
  list.id.substring(4)

changeSelected = (list) ->
  $(".list.selected").attr('class', 'list')
  $(list).toggleClass('list list selected')


