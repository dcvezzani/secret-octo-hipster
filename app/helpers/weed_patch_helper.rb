module WeedPatchHelper
  # def weed_patch_show(seed, variety)
  #   variety ||= seed.class.name.pluralize.tableize.gsub(/_/, "-")
  #   link_to seed, title: "Show", "data-load" => "###{variety}", class: "show-item" do
  #     raw("<i class='icon-search'></i>")
  #   end
  # end
  
  def link_to_iconable(label, path, options)
    options[:title] ||= label
    md = nil

    if((options[:class]) and (md = options[:class].match(/\b(new|edit|index|show|destroy)-item\b/)))
      icon_name = case(md[1])
        when "new"; "plus-sign"
        when "edit"; "pencil"
        when "destroy"; "trash"
        when "show"; "search"
        when "index"; "list"
      end

      icon_label = (options[:class].match("show-text")) ? label : ""

      link_to(path, options) do
        raw("<i class='icon-#{icon_name}'></i><div class='wp-icon-label'>#{icon_label}</div>")
      end
    else
      link_to(label, path, options)
    end
  end

  # variety: name for associated css selectors in html
  # seed: model instance
  def plant_weed_patch(variety, seed = nil)
    WeedPatch.new(seed, variety, self)
  end
  
  class WeedPatch
    def initialize(seed, variety, view_helper)
      @seed = seed
      @variety = variety
      @view_helper = view_helper
    end

    def show(seed = nil, variety = nil)
      seed ||= @seed
      variety ||= @variety

      @view_helper.link_to seed, title: "Show", "data-load" => "##{variety}", class: "show-item" do
        @view_helper.raw("<i class='icon-search'></i>")
      end
    end

    def edit(seed = nil, variety = nil)
      seed ||= @seed
      variety ||= @variety
      polymorphic_path = (seed.is_a?(Array)) ? [:edit].concat(seed) : [:edit, seed]

      @view_helper.link_to polymorphic_path, title: "Edit", "data-load" => "##{variety}", class: "edit-item" do
        @view_helper.raw("<i class='icon-pencil'></i>")
      end
    end

    def destroy(seed = nil, variety = nil)
      seed ||= @seed
      variety ||= @variety

      @view_helper.link_to seed, method: :delete, data: { confirm: 'Are you sure?' }, title: "Destroy", "data-load" => "##{variety}", class: "destroy-item" do
        @view_helper.raw("<i class='icon-trash'></i>")
      end
    end

    def add(seed = nil, variety = nil)
      seed ||= @variety.singularize
      variety ||= @variety
      link_label = "New #{variety.singularize.gsub(/_/, " ").capitalize}"
      polymorphic_path = (seed.is_a?(Array)) ? [:new].concat(seed) : [:new, seed]

      @view_helper.link_to link_label, polymorphic_path, "data-load" => "##{variety}", class: "new-item"
    end
    alias_method :add_link, :add

    def show_link(seed = nil, variety = nil)
      seed ||= @variety.singularize
      variety ||= @variety

      @view_helper.link_to 'Show', seed
    end
    
    def edit_link(seed = nil, variety = nil)
      seed ||= @variety.singularize
      variety ||= @variety
      polymorphic_path = (seed.is_a?(Array)) ? [:edit].concat(seed) : [:edit, seed]

      @view_helper.link_to 'Edit', polymorphic_path
    end
    
    def back_link(seed = nil, variety = nil)
      seed ||= @variety.singularize
      variety ||= @variety
      polymorphic_path = (seed.is_a?(Array)) ? seed << variety.to_sym : [seed, variety.to_sym]

      @view_helper.link_to 'Back', polymorphic_path
    end
    
   
    def varieties(actions = [], seed = nil, variety = nil)
      seed ||= @seed
      variety ||= @variety

      actions = actions.map do |action|
        @view_helper.content_tag(:td) do
          self.send(action, seed, variety)
        end
      end

      @view_helper.raw(actions.join("\n"))
    end

    def item_actions(seed = nil, variety = nil)
      seed ||= @seed
      variety ||= @variety

      actions = [:show, :edit, :destroy].map do |action|
        @view_helper.content_tag(:td) do
          self.send(action, seed, variety)
        end
      end

      @view_helper.raw(actions.join("\n"))
    end
    
  end
end
