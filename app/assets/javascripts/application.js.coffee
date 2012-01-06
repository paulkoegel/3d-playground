#= require jquery
#= require jquery_ujs
#= require jquery-ui-1.8.16-custom-min
#= require underscore-1.2.3-min
#= require ember-0.9.3
#= require functions
#= require_self
#= require_directory ./models
#= require_directory ./views
#= require_directory ./controllers
#= require games

# INITIALISATIONS
# ---------------

window.Irmingard = Ember.Application.create()

$.ajaxSetup
  'beforeSend': (xhr) ->
    xhr.setRequestHeader 'Accept', 'text/javascript'
