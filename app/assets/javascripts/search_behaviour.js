/**
 * Created by rails_user on 4/2/14.
 */
$(document).ready(function(){
    $('#js_search_type').children().click(function(){
        /* When someone clicks on our search dropdown
         * update dropdown button with translated text
         * update search_type val with key */
        var name = $(this).attr('id');
        var descr = $(this).children('a').text();
        $('#js_search_type_button').html(descr + " <span class='caret'></span>");
        $('input#js_search_field').val(name);
    });

    $('#appendedPrependedDropdownButton').on('keydown', function(e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            e.target.form.submit();
        }
    });
});