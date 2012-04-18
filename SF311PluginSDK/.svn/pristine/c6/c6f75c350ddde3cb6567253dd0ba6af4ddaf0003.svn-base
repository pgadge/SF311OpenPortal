/*
 * jQuery function for expand/collapse,
 * switch between the plus sign & 
 * the minus sign on click event
 */
(function(jQuery) {

jQuery.fn.toggler = function(options) {
    var defaults = {
         cllpsEl : 'div.collapse-faq',
         method : 'slideToggle',
         speed : 'fast',
         container : '', 
         initShow : '.shown' 
    };
    var upGif = '/partner-portal-theme/images/faq/close_btn.gif';
    var downGif = '/partner-portal-theme/images/faq/expand_btn.gif';
    var o = jQuery.extend({}, defaults, options);
    jQuery(this).find('img').attr('src', downGif);
    var jQuerythis = jQuery(this);
    jQuerythis.wrapInner('<a href="#" title="+/-" />');
    if (o.initShow) {jQuery(o.initShow).addClass('shown');}
    jQuerythis.next(o.cllpsEl + ':not(.shown)').hide();
    return this.each(function() {
      var container;
      (o.container) ? container = o.container : container = 'html';
      if (jQuerythis.next('div.shown').length) { jQuerythis.closest(container).find('.shown').show().prev().find('a').addClass('open'); }
      jQuery(this).click(function() {
        jQuery(this).find('a').toggleClass('open').end().next(o.cllpsEl)[o.method](o.speed);
		if(jQuery(this).find('img').attr('src') == upGif){
			jQuery(this).find('img').attr('src', downGif);
		} else{
			jQuery(this).find('img').attr('src', upGif);
		}
        return false;
    });
});};

})(jQuery);