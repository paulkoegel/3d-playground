pushToFaye = (element) ->
  url = (element.attr('action') || element.attr('href')) + '.js'
  $.ajax
      url: url
      type: 'PUT'
      context: document.body
      data: {'data': 'jaja'}
      success: ->
        element.addClass('done')

window.domToCard = (cardElement) ->
 $cardElement = $(cardElement)
 Irmingard.columnsController.content[$cardElement.data('column')].get('cards')[$cardElement.data('position')]
