$(document).on('click', '.js-modal, #js-modal .modal-body a', function(e) {
  var template = `
    <div class="modal fade container" id="js-modal" role="dialog">
    <div class="no-modal-dialog">
    <div class="modal-content">
    <div class="modal-header">
    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
    <h4 class="modal-title"></h4>
    </div>
    <div class="modal-body clearfix"></div>
    <div class="modal-footer"></div>
    </div>
    </div>
    </div>
  `;
  var self;
  self = $(this);
  if (self.data('toggle')) {
    return true;
  }
  if (self.attr('target')) {
    return true;
  }
  e.preventDefault();
  if ($('#js-modal').length === 0) {
    $('body').append(template);
  }
  var modal = $('#js-modal');
  modal.trigger('modal:loading', self.attr('href'));
  $.ajax({
    url: self.attr('href'),
    error: function(a, b, c) {
      modal.trigger('modal:changed', self.attr('href')).trigger('modal:error', self.attr('href'), a, b, c);
    },
    success: function(data) {
      var footer_provided;
      data = $('<div>' + data + '</div>');
      footer_provided = data.find('#modal-footer');
      if (footer_provided.length > 0) {
        modal.find('.modal-footer').html(footer_provided.remove().html());
      }
      modal.find('.modal-body').html(data.html());
      modal.html(modal.html());
      modal.trigger('modal-changed', self.attr('href')).trigger('modal:changed', self.attr('href'));
      if (!modal.is(':visible')) {
        modal.modal({
          show: true
        });
      }
    }
  });
});
$(document).on('submit', '#js-modal form', function(e) {
  var form = $(this);
  if (form.attr('target') === '_top' || form.attr('target') === '_parent') {
    return true;
  }
  $('#js-modal').trigger('modal:loading', form.attr('action'));
  e.preventDefault();
  $.ajax({
    url: form.attr("action"),
    type: form.attr('method') === 'GET' ? 'GET' : 'POST',
    data: form.serialize(),
    complete: function(d, e) {
      $('#js-modal').find('.modal-body').html(d.responseText);
      $('#js-modal').trigger('modal:changed', form.attr('action'));
    }
  });
  return false;
});
