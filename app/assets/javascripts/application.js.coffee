#= require jquery
#= require jquery_ujs
#= require jquery-ui-1.8.16-custom-min
#= require underscore-1.2.3-min
#= require three
#= require detector
#= require request_animation_frame
#= require stats
#= require_self
#= require 3d

# INITIALISATIONS
# ---------------

$.ajaxSetup
  'beforeSend': (xhr) ->
    xhr.setRequestHeader 'Accept', 'text/javascript'
