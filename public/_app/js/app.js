if (window.Helper===undefined || !window.Helper) window.Helper = new Object();

var CSS_PADDING = ['paddingTop','paddingRight','paddingBottom','paddingLeft'];
var CSS_MARGIN = ['marginTop','marginRight','marginBottom','marginLeft'];


var __entityMap = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': '&quot;',
    "'": '&#39;',
    "/": '&#x2F;'
};

String.prototype.escapeHTML = function() {
    return String(this).replace(/[&<>"'\/]/g, function (s) {
        return __entityMap[s];
    });
};

if (!String.prototype.trim) {
  String.prototype.trim = function () {
    return this.replace(/^\s+|\s+$/g, '');
  };
};

function encodeData(s){
    return encodeURIComponent(s).replace(/\-/g, "%2D").replace(/\_/g, "%5F").replace(/\./g, "%2E").replace(/\!/g, "%21").replace(/\~/g, "%7E").replace(/\*/g, "%2A").replace(/\'/g, "%27").replace(/\(/g, "%28").replace(/\)/g, "%29");
}

function decodeData(s){
    try{
        return decodeURIComponent(s.replace(/\%2D/g, "-").replace(/\%5F/g, "_").replace(/\%2E/g, ".").replace(/\%21/g, "!").replace(/\%7E/g, "~").replace(/\%2A/g, "*").replace(/\%27/g, "'").replace(/\%28/g, "(").replace(/\%29/g, ")"));
    }catch (e) {
    }
    return "";
}

/**
 * http://stackoverflow.com/questions/977883/selecting-only-first-level-elements-in-jquery
 * http://jsfiddle.net/nFGUJ/4/
 *
 */
jQuery.extend(jQuery.expr[':'], {
    topmost: function(e, index, match, array) {
        // Loop through matched element.
        for (var i = 0; i < array.length; i++) {
            // Check that `e` is not descendant of any
            // matched element.
            //
            //NOTE: false check is to skip already-
            // processed elements.
            if (array[i] !== false && $(e).parents().index(array[i]) >= 0) {
                return false;
            }
        }
        return true;
    }




});



$(document).ready(function () {	

	$('.text-hide-and-show').each(function (index) {
		var el = null;
		if ($(this).data('action-element')) el = $(this).data('action-element');
		else el = "h3";
		if ($(this).find(el).length===0) return ;
		$(this).find(el).eq(0).data('textDecorationOld', $(this).find(el).eq(0).css('textDecoration'));
		$(this).hover(
			function () {
				var _el = $(this).closest('.text-hide-and-show').find('.text-hide-and-show-content').eq(0);
				if (_el.is(':hidden')) {
					$(this).find(el).eq(0).css({
						textDecoration: "underline"
					});
				}
			}, function () {
				$(this).find(el).eq(0).css({
					textDecoration: $(this).find(el).eq(0).data('textDecorationOld')
				});
			}
		);
		$(this).click(function () {
			var _el = $(this).closest('.text-hide-and-show').find('.text-hide-and-show-content').eq(0);
			if (_el.is(':hidden')) {
				//$(this).find(el).click();
				_el.slideDown(function () {
						$(this).closest('.text-hide-and-show').addClass('active');
					});
				$(this).find(el).eq(0).css({
					textDecoration: $(this).find(el).eq(0).data('textDecorationOld')
				});
			}
		});
		$(this).find(el).eq(0).click(function () {
			var _el = $(this).closest('.text-hide-and-show').find('.text-hide-and-show-content').eq(0);
//			console.log(_el);
			if (_el.length>0) {
				if (_el.is(':hidden')) {
					/*_el.slideDown(function () {
						$(this).closest('.text-hide-and-show').addClass('active');
					});*/
				}
				else {
					_el.slideUp(function () {
						$(this).closest('.text-hide-and-show').removeClass('active');
					});
				}
			}
		});
	});
	
	$('a').click(function(){
		var href = $(this).attr('href');
		if (href) { // Sice špatnej odkaz, ale tak stane se ...
			if (href[0]=='#' && $( href ).length>0) {
				$('html, body').animate({
					scrollTop: $( href ).offset().top
				}, 500);
				$(href).focus();
				return false;
			}
			return true;
		}
	});

});

function initJqUI() {
	/*$(".datepicker").datepicker({
		inline: true
	});*/
}

function checkboxyCheckedVse(el) {
	$(el).find("input[type=checkbox]").attr('checked', 'checked');
}

function checkboxyCheckedNic(el) {
	$(el).find("input[type=checkbox]").val(["0"]);;
}

function checkboxyCheckedInv(el) {
	chbs = $(el).find("input[type=checkbox]");
	for (i = 0;i < chbs.length; i++) {
		if (chbs.eq(i).is(':checked')) chbs.eq(i).val(["0"]);
		else chbs.eq(i).attr('checked', 'checked');
	}
}


function jsonMessageSimple(jsonData) {
	var msg = "Hlášení: ";
	msg += "\n";
	msg += "========================================";
	for (var i = 0; i < data.hlaseni.length; i++) {
		msg += "\n";
		msg += data.hlaseni[i].zprava;
	}
	if (data.content) {
		msg += "\n";
		msg += "\n";
		msg += "Obsah: ";
		msg += "\n";
		msg += "========================================";
		msg += "\n";
		msg += data.content;
	}
	alert(msg);
}


Helper.UnkownHandler = function () {
	alert('Handler nebyl definován');
};

/*
 * ============================= LOADER =============================
 */

var HTML_LOADER_RUNNING_TEXT = "Vyčkejte, načítám data&hellip;";
var HTML_LOADER_ERROR_TEXT = "Data se nepodařilo načíst&hellip;";

function loaderRunningHtml(el, text) {
	if (!text) text = HTML_LOADER_RUNNING_TEXT;
	if (el.length==0) return false;
	el.html("<div class=\"loader\"><span>"+text+"</span></div>");
	return true;
}

function loaderErrHtml(el, text) {
	if (!text) text = HTML_LOADER_ERROR_TEXT;
	if (el.length==0) return false;
	el.html("<div class=\"loader-err\"><span>"+text+"</span></div>");
	return true;
}





/* IE testy */
function isIE6() {
	return ($.browser.msie && parseInt($.browser.version, 10) == 6);
}

function isIE7() {
	return ($.browser.msie && parseInt($.browser.version, 10) == 7);
}

function isIE8() {
	return ($.browser.msie && parseInt($.browser.version, 10) == 8);
}

function isIEOld() {
	if (isIE6()) return true;
	if (isIE7()) return true;
	if (isIE8()) return true;
	return false;
}

function isIE() {
	return $.browser.msie;
}
/* /IE testy */





function number_format (number, decimals, dec_point, thousands_sep) {
  // http://kevin.vanzonneveld.net

  // Strip all characters but numerical ones.
  number = (number + '').replace(/[^0-9+\-Ee.]/g, '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function (n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

$(document).ready(function () {
	$("a.extern, a > span.extern").click(function () {
		return !window.open($(this).attr('href'));
	});
});


/**
 *
 * @returns {Hlaseni}
 */
function Hlaseni(el, withClean) {
	this.htmlId = "#hlaseni";
	if (withClean===undefined) withClean = false;
	if (el) this.setHtmlId(el, withClean);
	this.append = true;
}

Hlaseni.ALERT_WARNING = 2;
Hlaseni.ALERT_SUCCESS = 1;
Hlaseni.ALERT_INFO = 0;
Hlaseni.ALERT_ERROR = -1;
Hlaseni.ALERT_FATAL = -2;
Hlaseni.ALERT_INVERSE = -3;

Hlaseni.Create = function (el, withClean) {
	return new Hlaseni(el, withClean);
};

Hlaseni.prototype.setAppend = function (append) {
	this.append = append;
};

Hlaseni.prototype.setHtmlId = function (id, withClean) {
	this.htmlId = id;
	if (withClean===undefined) withClean = false;
	if (withClean) $(this.htmlId).children().remove();
	return this;
};

Hlaseni.prototype.getHtmlId = function () {
	return this.htmlId;
};

Hlaseni.prototype._elAlert = function(text, type) {
	var el = $("<div />");
	el.addClass("alert");
	switch (type) {
		case Hlaseni.ALERT_WARNING: el.addClass(""); break;
		case Hlaseni.ALERT_SUCCESS: el.addClass("alert-success"); break;
		case Hlaseni.ALERT_INFO: el.addClass("alert-info"); break;
		case Hlaseni.ALERT_ERROR: el.addClass("alert-error"); break;
		case Hlaseni.ALERT_FATAL: el.addClass("alert-fatal"); break;
		case Hlaseni.ALERT_INVERSE: el.addClass("alert-inverse"); break;
	};
	el.html(text);
	return el;
};

Hlaseni.prototype._elAlertWithId = function(text, type, id) {
	var alert = this._elAlert(text, type);
	if (id !== undefined) alert.attr('id', id);
	return alert;
};

Hlaseni.prototype.add = function (text, type, id) {
	var alert = this.addWithoutCloseButton(text, type, id);
	alert.prepend("<button class=\"close\" data-dismiss=\"alert\" type=\"button\">&times;</button>");
	return alert;
};

Hlaseni.prototype.addWithoutCloseButton = function (text, type, id) {
	var alert = this._elAlertWithId(text, type, id);
	if (this.append) $(this.htmlId).append(alert);
	else $(this.htmlId).prepend(alert);
	return alert;
};

/**
 * Netestováno
 *
 * @param {type} id
 * @returns {undefined}
 */
Hlaseni.prototype.removeId = function (id) {
	if (id[0]==='#') id = id.substring(1);
	$(this.htmlId).remove("#" + id);
};

Hlaseni.prototype.clear = function () {
	$(this.htmlId).empty();
};