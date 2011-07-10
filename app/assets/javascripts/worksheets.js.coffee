# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('#worksheet-tabs').tabs()
  $('a.button, input:submit').button()
  $('a.button.edit').button('option', 'icons', {primary: 'ui-icon-pencil'})
  $('a.button.delete').button('option', 'icons', { primary: 'ui-icon-trash'})
  $('a.button.new').button('option', 'icons', { primary: 'ui-icon-plus'})