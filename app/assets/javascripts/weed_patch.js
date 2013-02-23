function WeedPatch(variety, options){
  this.variety = variety;
  options = (typeof(options) == "undefined") ? {} : options;

  this.response_target = function(request_target){
    //return ($(this).attr("data-load") || this.variety);
    return ($(request_target).attr("data-load") || "#" + this.variety);
    //return $(request_target).attr("data-load");
  }

  this.register_index_item = function(variety){
    var self = this;

    $(".new-item, .edit-item, .show-item", variety).click(function(){
      var href = $(this).attr("href");
      Clf005.Wizard.Widgets.get_partial(href, self.response_target(this));

      return false;
    });

    $(".destroy-item", variety).click(function(){
      var href = $(this).attr("href");
      var csrf_token = $("meta[csrf-token]").attr("content");
      var data = "authenticity_token=" + csrf_token + "&_method=delete&utf8=✓";
      Clf005.Wizard.Widgets.post_partial(href, self.response_target(this), data);

      return false;
    });
  }

  this.register_simple_items = function(variety, items){
    var self = this;

    items = (typeof(items) == "undefined") ? "" : items;
    if(items.length < 1){ return false; }

    $(items, variety).click(function(){
      var href = $(this).attr("href");
      console.log("response target: " + self.response_target(this));
      Clf005.Wizard.Widgets.get_partial(href, self.response_target(this));

      return false;
    });
  }
  
  this.register_submit_form = function(variety){
    var self = this;

    $("form", variety).submit(function(){
      var href = $(this).attr("action");
      Clf005.Wizard.Widgets.post_partial(href, self.response_target(this), $(this).serialize());

      return false;
    });
  }

  this.bloom = function(action){
    switch(action){
      case 'index':
        this.register_index_item("#" + this.variety);
        break;

      case 'form':
        this.register_submit_form("#" + this.variety);
        break;

      case 'edit':
        this.register_simple_items("#" + this.variety, ".show-item, .index-item")
        break;

      case 'new':
        this.register_simple_items("#" + this.variety, ".index-item")
        break;

      case 'show':
        this.register_simple_items("#" + this.variety, ".edit-item, .index-item")
        break;

      default:
        this.register_simple_items("#" + this.variety, action)
    }
  }

  this.register_retrieval_button = function(variety){
    var self = this;

    $(".btn-" + variety).click(function(){
      var href = $(this).attr("href");
      Clf005.Wizard.Widgets.get_partial(href, self.response_target(this));
      return false;
    });
  }

  if(!options.dormant){
    console.log("'" + this.variety + "' weeds were planted; get ready for hay fever season!")
    this.register_retrieval_button(this.variety);

    $(".btn-autoload").click();
    $(".btn-autoload").hide();
  }
}

