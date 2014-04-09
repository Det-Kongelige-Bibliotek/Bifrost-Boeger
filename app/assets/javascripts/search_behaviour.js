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

    /*
     * Prevents an enter pressed in the search input from opening the search type dropdown
     */
    $('#appendedPrependedDropdownButton').on('keydown', function(e) {
        if (e.keyCode === 13) {
            e.preventDefault();
            e.target.form.submit();
        }
    });

    /*
     * Toggles the tabindex on and off on facet_selects according to whether they are collapsed or expanded
     * If it is called without parameters, it will invert the resulting tabindex (since using it as an eventhandler will pass on an event)
     * We need this because the eventhandler is called BEFORE collapse/expand and therefore height=0 => tabindex=0
     * When initializing the elements, height=0 => tabindex=-1 (because they are not about to expand). Gee - explain this better anyone? :-6
     */
    var toggleFacetSelectsTabOrder = function (e) {
        var collapsePanel = $(this).closest('.accordion-heading').next('.collapse'),
            shouldBeInTabIndex = collapsePanel.css('height') === '0px'; // a bit upside down, because this is BEFORE the transition
            shouldBeInTabIndex = (typeof e === 'undefined') ? !shouldBeInTabIndex : shouldBeInTabIndex;
            $('.facet_select', collapsePanel).attr('tabindex', (shouldBeInTabIndex ? '0' : '-1'));
    };
    $('.facets .accordion-toggle').each(function(index, facetHeader){ // initialize tabindex for facet headers
        toggleFacetSelectsTabOrder.call(facetHeader);
    });
    $('.facets .accordion-toggle').click(toggleFacetSelectsTabOrder); // setup event listener on facet headers
});