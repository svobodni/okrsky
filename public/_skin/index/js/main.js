function htmlDecode(t){
   if (t) return $('<div />').html(t).text();
}

$(document).ready(function() {	
    $("a.fancy, a.image").fancybox({
		type		:	"image",
		speedIn		:	200,
		speedOut	:	200,
		overlayShow	:	true,
		titlePosition: 'over',
		/*'onComplete'	:	function() {
			$("#fancybox-wrap").hover(function() {
				$("#fancybox-title").show();
			}, function() {
				$("#fancybox-title").hide();
			});
		},*/
		'titleFormat'		: function(title, currentArray, currentIndex, currentOpts) {
			var text = '<div id="fancybox-title-over">';
			text += "<div class=\"title\">";
			text += '<span>Fotografie ' + (currentIndex + 1) + ' / ' + currentArray.length + "</span>";
			if (title.length) text += ' &nbsp; <strong>' + title.toString().escapeHTML() + "</strong>";
			text += "</div>";
			if ($(currentArray[currentIndex]).data("fancy-desc")) text += '<div class="desc">' + $(currentArray[currentIndex]).data("fancy-desc").toString().escapeHTML().split("\n").join("\n<br />")+"</div>";
			text += '</div>';
			return text;
		}
    });

});


function loadUcet(key, el, elVybrano, max) {
        var request = $.ajax({
			type: "GET",
			url: ADRESAR_X+"_app.project/index/ext/ucty.php?key=" + key,
			dataType: "json"
        });
		request.done(function(data) {
			var text = "";
			if (data.error) {
				text += "<span class=\"error\">Data se nepoda&#345;ilo na&#269;&iacute;st, zkuste to znovu<\/span>";
			}
			else {
				text += "<span class=\"resul\">"+number_format(data.value, 2, ',', ' ')+"<\/span>";

				var current = data.value;
				if (current>=max) {
					current = max;
				}

				var elVybranoIn = $("<div />")
							.addClass('vybrano-in')
							.css('width', ((current * 1) / max) * $("#vybrano").innerWidth());

				if (current==max) elVybrano.addClass('vybrano-vse');

				$(elVybrano).html('').children().remove();

				$(elVybrano)
					.addClass('vybrano')
					.append(elVybranoIn);

			}
			$(el).html(text);
		});
}


