if (typeof jQuery !== 'undefined') {
	(function($) {
		$('#spinner').ajaxStart(function() {
			$(this).fadeIn();
		}).ajaxStop(function() {
			$(this).fadeOut();
		});
	})(jQuery);
}

var treneoFontsAndColors = function() {
	var fonts = ["Sue Ellen Francisco, cursive","Duru Sans, sans-serif","Quicksand, sans-serif","Oleo Script Swash Caps, cursive","Vast Shadow, cursive","Smokum, cursive","Montserrat Alternates, sans-serif","Shojumaru, cursive","Peralta, cursive","Prosto One, cursive","Kavoon, cursive","Bubbler One, sans-serif","Ceviche One, cursive","Ribeye Marrow, cursive"];
	var colors = ['#34a5aa', '#aaaaaa', '#4789aa', '#d3e310'];

    $('.treneo').css('color', colors[(Math.random() * 4) | 0 + 1]);
    $('.treneo').css('font-family', fonts[(Math.random() * 11) | 0 + 1]);
}

var typeahead = function(url) {
    var extractor = function(query) {
      var result = /([^ ]+)$/.exec(query);
      if(result && result[1])
        return result[1].trim();
      return '';
    }

    var updater = function(item) {
      //return this.$element.val().replace(/[^ ]*$/,'')+item+' ';
      return item + ' ';
    }

    var matcher = function (item) {
      var tquery = extractor(this.query);
      if(!tquery) return false;
      return ~item.toLowerCase().indexOf(tquery.toLowerCase());
    }

    var highlighter = function (item) {
      var query = extractor(this.query).replace(/[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&')
      return item.replace(new RegExp('(' + query + ')', 'ig'), function ($1, match) {
        return '<strong>' + match + '</strong>'
      });
    }          

    var ta = $('#q').typeahead({
        source: function(query, process) {
          return $.ajax( {
              dataType: "json",
              url: url,
              type: 'POST',
              data: {query: query},
              success: function(json) {
                process(json);
              },
            });              
        },
        minLength: 1,
        items: 8,
        updater: updater,
        matcher: matcher,
        highlighter: highlighter
      });

}