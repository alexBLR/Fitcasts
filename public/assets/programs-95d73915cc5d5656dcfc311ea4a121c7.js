(function() {
  $.rails.allowAction = function(link) {
    if (!link.attr('data-confirm')) {
      return true;
    }
    $.rails.showConfirmDialog(link);
    return false;
  };

  $.rails.confirmed = function(link) {
    link.removeAttr('data-confirm');
    link.trigger('click.rails');
    if (linkclass === 'reset-link') {
      return window.location.replace("" + link.context.href + "");
    }
  };

  $.rails.showConfirmDialog = function(link) {
    var html, message;
    message = link.attr('data-confirm');
    html = "<div class=\"modal\" id=\"confirmationDialog\">\n  <div class=\"modal-header\">\n    <a class=\"close\" data-dismiss=\"modal\">×</a>\n    <h3>" + message + "</h3>\n  </div>\n  <div class=\"modal-body\">\n    <p>If you are already enrolled in a program all you data will be lost associated with it.</p>\n  </div>\n  <div class=\"modal-footer\">\n    <a data-dismiss=\"modal\" class=\"btn\">Cancel</a>\n    <a data-dismiss=\"modal\" class=\"btn btn-primary confirm\">OK</a>\n  </div>\n</div>";
    $(html).modal();
    $('#confirmationDialog .confirm').on('click', function() {
      return $.rails.confirmed(link);
    });
    jQuery(function() {});
    return $('.datepicker').datepicker({
      format: 'yyyy-dd-mm'
    });
  };

}).call(this);
