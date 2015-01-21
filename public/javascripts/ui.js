(function (window, document) {

    var layout   = document.getElementById('layout'),
        menu     = document.getElementById('menu'),
        menuLink = document.getElementById('menuLink');

    function toggleClass(element, className) {
        var classes = element.className.split(/\s+/),
            length = classes.length,
            i = 0;

        for(; i < length; i++) {
          if (classes[i] === className) {
            classes.splice(i, 1);
            break;
          }
        }
        // The className is not found
        if (length === classes.length) {
            classes.push(className);
        }

        element.className = classes.join(' ');
    }

    menuLink.onclick = function (e) {
        var active = 'active';

        e.preventDefault();
        toggleClass(layout, active);
        toggleClass(menu, active);
        toggleClass(menuLink, active);
    };

}(this, this.document));

$(function () {
  $('textarea[data-ace]').each(function () {
    var textarea = $(this);

    var mode = textarea.data('ace');

    var editorDiv = $('<div>', {
      position: 'absolute',
      width: textarea.width(),
      height: textarea.height(),
      'class': textarea.attr('class')
    }).insertBefore(textarea);

    textarea.css('visibility', 'hidden');

    var editor = ace.edit(editorDiv[0]);
    editor.$blockScrolling = Infinity;
    editor.getSession().setValue(textarea.val());
    editor.getSession().setMode('ace/mode/' + mode);

    textarea.closest('form').submit(function  () {
      textarea.val(editor.getSession().getValue());
    });
  });
})
