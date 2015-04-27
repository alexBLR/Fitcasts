
$.rails.allowAction = (link) ->
  return true unless link.attr('data-confirm')
  $.rails.showConfirmDialog(link) # look bellow for implementations
  false # always stops the action since code runs asynchronously

$.rails.confirmed = (link) ->
  link.removeAttr('data-confirm')
  link.trigger('click.rails')

  if linkclass == 'reset-link'
  	window.location.replace(""+link.context.href+"");


$.rails.showConfirmDialog = (link) ->
  message = link.attr 'data-confirm'
  html = """
         <div class="modal" id="confirmationDialog">
           <div class="modal-header">
             <a class="close" data-dismiss="modal">×</a>
             <h3>#{message}</h3>
           </div>
           <div class="modal-body">
             <p>If you are already enrolled in a program all you data will be lost associated with it.</p>
           </div>
           <div class="modal-footer">
             <a data-dismiss="modal" class="btn">Cancel</a>
             <a data-dismiss="modal" class="btn btn-primary confirm">OK</a>
           </div>
         </div>
         """
  $(html).modal()
  $('#confirmationDialog .confirm').on 'click', -> $.rails.confirmed(link)

  jQuery ->
  $('.datepicker').datepicker({format: 'yyyy-dd-mm'})
  

