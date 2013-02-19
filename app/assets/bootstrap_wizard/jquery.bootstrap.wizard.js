/*!
 * jQuery twitter bootstrap wizard plugin
 * Examples and documentation at: http://github.com/VinceG/twitter-bootstrap-wizard
 * version 1.0
 * Requires jQuery v1.3.2 or later
 * Dual licensed under the MIT and GPL licenses:
 * http://www.opensource.org/licenses/mit-license.php
 * http://www.gnu.org/licenses/gpl.html
 * Authors: Vadim Vincent Gabriel (http://vadimg.com)
 */
;(function($) {
var bootstrapWizardCreate = function(element, options) {
	var element = $(element);
	var obj = this;

	// Merge options with defaults
	//var $settings = $.extend($.fn.bootstrapWizard.defaults, options || {});
	var $settings = $.extend({}, $.fn.bootstrapWizard.defaults, options);
	var $activeTab = null;
	var $navigation = null;

	this.fixNavigationButtons = function() {
		// Get the current active tab
		if(!$activeTab.length) {
			// Select first one
			$navigation.find('a[data-toggle]:first').tab('show');
			$activeTab = $navigation.find('li:first');
		}

		// See if we currently in the first then disable the previous and last buttons
		if(obj.firstIndex() >= obj.currentIndex()) {
			$('li.previous', element).addClass('disabled');
		} else{
			$('li.previous', element).removeClass('disabled');
		}

		if(obj.currentIndex() >= obj.navigationLength()) {
			$('li.next', element).addClass('disabled');
		} else {
			$('li.next', element).removeClass('disabled');
		}

		if($settings.onTabShow && typeof $settings.onTabShow === 'function' && $settings.onTabShow($activeTab, $navigation, obj.currentIndex(), obj.currentIndex())===false){
			return false;
		}
	};

	this.next = function(e) {

		// If we clicked the last then dont activate this
		if(element.hasClass('last')) {
			return false;
		}

		if($settings.onNext && typeof $settings.onNext === 'function' && $settings.onNext($activeTab, $navigation, obj.currentIndex(), obj.nextIndex())===false){
			return false;
		}

		// Did we click the last button
		$index = obj.nextIndex();
		if($index > obj.navigationLength()) {
		} else {
      var nextTab = obj.nextAvailableTab($activeTab);
      obj.gotoTab(nextTab);
			//$navigation.find('li:eq('+$index+') a[data-toggle]').tab('show');
		}
	};

	this.previous = function(e) {

		// If we clicked the first then dont activate this
		if(element.hasClass('first')) {
			return false;
		}

		if($settings.onPrevious && typeof $settings.onPrevious === 'function' && $settings.onPrevious($activeTab, $navigation, obj.currentIndex(), obj.previousIndex())===false){
			return false;
		}

		$index = obj.previousIndex();
		if($index < 0) {
		} else {
      var prevTab = obj.prevAvailableTab($activeTab);
      obj.gotoTab(prevTab);
			//$navigation.find('li:eq('+$index+') a[data-toggle]').tab('show');
		}
	};

	this.first = function(e) {
		if($settings.onFirst && typeof $settings.onFirst === 'function' && $settings.onFirst($activeTab, $navigation, obj.currentIndex(), obj.firstIndex())===false){
			return false;
		}

		// If the element is disabled then we won't do anything
		if(element.hasClass('disabled')) {
			return false;
		}
    var firstTab = obj.firstAvailableTab($activeTab);
    obj.gotoTab(firstTab);
		//$navigation.find('li:eq(0) a[data-toggle]').tab('show');

	};
	this.last = function(e) {
		if($settings.onLast && typeof $settings.onLast === 'function' && $settings.onLast($activeTab, $navigation, obj.currentIndex(), obj.lastIndex())===false){
			return false;
		}

		// If the element is disabled then we won't do anything
		if(element.hasClass('disabled')) {
			return false;
		}
    var lastTab = obj.lastAvailableTab($activeTab);
    obj.gotoTab(lastTab);
		//$navigation.find('li:eq('+obj.navigationLength()+') a[data-toggle]').tab('show');
	};


  // BEGIN: Custom sequences to handle case when wizard item has been disabled
  this.gotoTab = function(tab){
    // $(tab).find("a").click();
    // $(tab).find("a").click({asdf: "asdf"});
    $(tab).find("a").trigger('click', [true]);

    $(".navbar-inner li.active", element).removeClass("active");
    $(tab).addClass("active");

    //var current_index = obj.getIndex(tab);
    //($settings.onTabLoad && typeof $settings.onTabLoad === 'function' && $settings.onTabLoad(tab, $navigation, current_index)
    // if($settings.onTabLoad && typeof $settings.onTabLoad === 'function'){
    //   $settings.onTabLoad($activeTab, $navigation, obj.currentIndex());
    // }
  }

  this.xgotoTab = function(tab){
		$activeTab = tab; // activated tab

		if($activeTab.hasClass('disabled')) {
			return false;
		}

		obj.fixNavigationButtons();

    $(".navbar-inner li.active", element).removeClass("active");
    $($activeTab).addClass("active");


    //var current_index = obj.getIndex(tab);
    //($settings.onTabLoad && typeof $settings.onTabLoad === 'function' && $settings.onTabLoad(tab, $navigation, current_index)
    // if($settings.onTabLoad && typeof $settings.onTabLoad === 'function'){
    //   $settings.onTabLoad($activeTab, $navigation, obj.currentIndex());
    // }
  }

  this.firstAvailableTab = function(currentTab){
    var nextTab = null;
    $(".navbar li", element).not(".disabled");

    var nodes = $(".navbar-inner li", $('#rootwizard')).not(".disabled");
    for(var i=0; i<nodes.length; i++){
      var node = nodes[i];
      if(!nextTab){
        if (!$(node).hasClass("disabled")) {
          nextTab = $(node);
          break;
        }
      }
    }

    //console.log(nextTab)
    //$('#rootwizard').data("bootstrapWizard").gotoTab(nextTab)
    return nextTab;
  }

  this.lastAvailableTab = function(currentTab){
    var nextTab = null;
    $(".navbar li", element).not(".disabled");

    var nodes = $(".navbar-inner li", $('#rootwizard')).not(".disabled");
    for(var i=(nodes.length-1); i>=0; i--){
      var node = nodes[i];
      if(!nextTab){
        if (!$(node).hasClass("disabled")) {
          nextTab = $(node);
          break;
        }
      }
    }

    //console.log(nextTab)
    //$('#rootwizard').data("bootstrapWizard").gotoTab(nextTab)
    return nextTab;
  }

  this.nextAvailableTab = function(currentTab){
    var fnd = false;
    var nextTab = null;
    $(".navbar li", element).not(".disabled");

    var nodes = $(".navbar-inner li", $('#rootwizard')).not(".disabled");
    for(var i=0; i<nodes.length; i++){
      var node = nodes[i];
      //fnd = ($(node).attr("class") == $(currentTab).attr("class"));
      if(fnd && !nextTab){
        if (!$(node).hasClass("disabled")) {
          nextTab = $(node);
          break;
        }
      } else {
        fnd = ($(node).attr("class") == $(currentTab).attr("class"));
      }
    }

    //console.log(nextTab)
    //$('#rootwizard').data("bootstrapWizard").gotoTab(nextTab)
    return nextTab;
  }

  this.prevAvailableTab = function(currentTab){
    var fnd = false;
    var nextTab = null;
    $(".navbar li", element).not(".disabled");

    var nodes = $(".navbar-inner li", $('#rootwizard')).not(".disabled");
    for(var i=(nodes.length-1); i>=0; i--){
      var node = nodes[i];
      //fnd = ($(node).attr("class") == $(currentTab).attr("class"));
      if(fnd && !nextTab){
        if (!$(node).hasClass("disabled")) {
          nextTab = $(node);
          break;
        }
      } else {
        fnd = ($(node).attr("class") == $(currentTab).attr("class"));
      }
    }

    //console.log(nextTab)
    //$('#rootwizard').data("bootstrapWizard").gotoTab(nextTab)
    return nextTab;
  }


	this.nextAvailIndex = function() {
		var cur_nav_item = $activeTab
    var next_nav_item = cur_nav_item.next();
    var cnt = 0;
    while((cnt < 100) && next_nav_item){
      if(next_nav_item.hasClass("disabled")){
        cnt += 1;
        next_nav_item = next_nav_item.next();
        continue;
      }
      break;
    }

    return obj.getIndex(next_nav_item || cur_nav_item);
  }
	this.firstAvailIndex = function() {
		var cur_nav_item = $navigation.find('li').first();
    var prev_nav_item = cur_nav_item.prev();
    var cnt = 0;
    while((cnt < 100) && prev_nav_item){
      if(prev_nav_item.hasClass("disabled")){
        cnt += 1;
        prev_nav_item = prev_nav_item.prev();
        continue;
      }
      break;
    }

    return obj.getIndex(prev_nav_item || cur_nav_item);
  }
	this.prevAvailIndex = function() {
		var cur_nav_item = $activeTab
    var prev_nav_item = cur_nav_item.prev();
    var cnt = 0;
    while((cnt < 100) && prev_nav_item){
      if(prev_nav_item.hasClass("disabled")){
        cnt += 1;
        prev_nav_item = prev_nav_item.prev();
        continue;
      }
      break;
    }

    return obj.getIndex(prev_nav_item || cur_nav_item);
  }
	this.lastAvailIndex = function() {
		var cur_nav_item = $navigation.find('li').last();
    var next_nav_item = cur_nav_item.next();
    var cnt = 0;
    while((cnt < 100) && next_nav_item){
      if(next_nav_item.hasClass("disabled")){
        cnt += 1;
        next_nav_item = next_nav_item.next();
        continue;
      }
      break;
    }

    return obj.getIndex(next_nav_item || cur_nav_item);
  }
  // END: Custom sequences to handle case when wizard item has been disabled


	this.currentIndex = function() {
		return $navigation.find('li').index($activeTab);
	};
	this.firstIndex = function() {
    return obj.firstAvailIndex();
		//return 0;
	};
	this.lastIndex = function() {
    return obj.lastAvailIndex();
		//return obj.navigationLength();
	};
	this.getIndex = function(elem) {
		return $navigation.find('li').index(elem);
	};
	this.nextIndex = function() {
    return obj.nextAvailIndex();
		//return $navigation.find('li').index($activeTab) + 1;
	};
	this.previousIndex = function() {
    return obj.prevAvailIndex();
		//return $navigation.find('li').index($activeTab) - 1;
	};
	this.navigationLength = function() {
		return $navigation.find('li').length - 1;
	};
	this.activeTab = function(tab) {
    if(arguments.length > 0){
      $activeTab = tab;
    }

		return $activeTab;
	};
	this.nextTab = function() {
		return $navigation.find('li:eq('+(obj.currentIndex()+1)+')').length ? $navigation.find('li:eq('+(obj.currentIndex()+1)+')') : null;
	};
	this.previousTab = function() {
		if(obj.currentIndex() <= 0) {
			return null;
		}
		return $navigation.find('li:eq('+parseInt(obj.currentIndex()-1)+')');
	};

	$navigation = element.find('ul:first', element);
	$activeTab = $navigation.find('li.active', element);

	if(!$navigation.hasClass($settings.tabClass)) {
		$navigation.addClass($settings.tabClass);
	}

	// Load onShow
	if($settings.onInit && typeof $settings.onInit === 'function'){
		$settings.onInit($activeTab, $navigation, 0);
	}

	// Next/Previous events
	$($settings.nextSelector, element).bind('click', obj.next);
	$($settings.previousSelector, element).bind('click', obj.previous);
	$($settings.lastSelector, element).bind('click', obj.last);
	$($settings.firstSelector, element).bind('click', obj.first);

	// Load onShow
	if($settings.onShow && typeof $settings.onShow === 'function'){
		$settings.onShow($activeTab, $navigation, obj.nextIndex());
	}

	// Work the next/previous buttons
	obj.fixNavigationButtons();

  // Adds optional parameter that prevents onTabClick callback from being used.
  // This is useful at the present time when the button selector callbacks are used
  // and ajax calls will be made to populate wizard sections, save, validate, etc.
  //
  // ***************
  //
	$('a[data-toggle="tab"]', element).on('click', function (e, skipOnTabClick) {
		if(!skipOnTabClick && $settings.onTabClick && typeof $settings.onTabClick === 'function' && $settings.onTabClick($activeTab, $navigation, obj.currentIndex(), obj.currentIndex())===false){
			return false;
		} 
	});

	$('a[data-toggle="tab"]', element).on('show', function (e) {
		$element = $(e.target).parent();
		// If it's disabled then do not change
		if($element.hasClass('disabled')) {
			return false;
		}

		$activeTab = $element; // activated tab
		obj.fixNavigationButtons();

	});
};
$.fn.bootstrapWizard = function(options) {
	return this.each(function(index){
		var element = $(this);
		// Return early if this element already has a plugin instance
		if (element.data('bootstrapWizard')) return;
		// pass options to plugin constructor
		var wizard = new bootstrapWizardCreate(element, options);
		// Store plugin object in this element's data
		element.data('bootstrapWizard', wizard);
	});
};

// expose options
$.fn.bootstrapWizard.defaults = {
	'tabClass':            'nav nav-pills',
	'nextSelector':     '.wizard li.next',
	'previousSelector': '.wizard li.previous',
	'firstSelector':    '.wizard li.first',
	'lastSelector':     '.wizard li.last',
	'onShow':           null,
	'onInit':           null,
	'onNext':           null,
	'onPrevious':       null,
	'onLast':           null,
	'onFirst':          null,
	'onTabClick':       null,
	'onTabShow':        null
  // 'onTabLoad':        null
};

})(jQuery);
