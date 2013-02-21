module ClientHelper
    RSpec::Matchers.define :include_tenant do |expected_tenant|
      match do |actual_tenants|
        actual_tenants.include?(expected_tenant)
      end
    end
    RSpec::Matchers.define :include_recipient do |expected_recipient|
      match do |actual_recipients|
        actual_recipients.include?(expected_recipient)
      end
    end
    RSpec::Matchers.define :have_children_count do |expected|
      match do |tenants|
        @actual_children = tenants.select{|tenant| tenant.is_a?(Child)}.length
        expected == @actual_children
      end

      failure_message_for_should do |actual|
        "expected the number of children to be #{expected}, but there appear to be #{@actual_children} instead"
      end
    end
    RSpec::Matchers.define :have_items_count do |expected, type=nil|
      match do |actual_collection|
        type = actual_collection.first.class if(type.nil? and actual_collection.length > 0 and !actual_collection.first.nil?)
        @filtered_collection = actual_collection.select{|item| item.is_a?(type)}
        @filtered_collection.length == expected
      end

      failure_message_for_should do |actual_collection|
        "expected #{expected} #{type.name.pluralize.tableize.downcase.gsub(/_/, " ")} to be included in collection, but got #{@filtered_collection.length}"
      end
    end
    RSpec::Matchers.define :have_item_with do |attr, expected|
      match do |actual_collection|
        @actual_item = actual_collection.find{|item| item.send(attr) == expected}
        !@actual_item.nil?
      end

      failure_message_for_should do |actual_collection|
        "expected #{actual_collection} to have an item whose #{attr} has a value of '#{expected}', but found none"
      end
    end

    RSpec::Matchers.define :have_more_entries_than do |right_obj|
      match do |left_obj|
        @left_obj = left_obj
        @left_obj_size = ((@current_time) ? left_obj.where{created_at > my{@current_time}} : left_obj).count

        if(right_obj.is_a?(Integer))
          @right_obj_size = right_obj

        else
        #if(right_obj.ancestors.include?(ActiveRecord::Base))
          @right_obj_size = ((@current_time) ? right_obj.where{created_at > my{@current_time}} : right_obj).count

        end

        (@left_obj_size > @right_obj_size)
      end

      chain :after do |current_time|
        @current_time = current_time
      end

      failure_message_for_should do |actual_collection|
        if(right_obj.is_a?(Integer))
          "expected #{@left_obj.name} (#{@left_obj_size}) to have more than #{@right_obj_size} entries"
        else
          "expected #{@left_obj.name} (#{@left_obj_size}) to have more entries than #{right_obj.name} (#{@right_obj_size})"
        end
      end
    end

    # TODO: refactor :have_more_entries_than and :have_less_entries_than to DRY things up
    RSpec::Matchers.define :have_less_entries_than do |right_obj|
      match do |left_obj|
        @left_obj = left_obj
        @left_obj_size = ((@current_time) ? left_obj.where{created_at > my{@current_time}} : left_obj).count

        if(right_obj.is_a?(Integer))
          @right_obj_size = right_obj

        else
        #if(right_obj.ancestors.include?(ActiveRecord::Base))
          @right_obj_size = ((@current_time) ? right_obj.where{created_at > my{@current_time}} : right_obj).count

        end

        (@left_obj_size < @right_obj_size)
      end

      chain :after do |current_time|
        @current_time = current_time
      end

      failure_message_for_should do |actual_collection|
        if(right_obj.is_a?(Integer))
          "expected #{@left_obj.name} (#{@left_obj_size}) to have less than #{@right_obj_size} entries"
        else
          "expected #{@left_obj.name} (#{@left_obj_size}) to have less entries than #{right_obj.name} (#{@right_obj_size})"
        end
      end
    end


    RSpec::Matchers.define :have_an_entries_count_of do |expected_count|
      match do |obj|
        @obj = obj
        @obj_size = ((@current_time) ? obj.where{created_at > my{@current_time}} : obj).count
        (@obj_size == expected_count)
      end

      chain :after do |current_time|
        @current_time = current_time
      end

      failure_message_for_should do |actual|
        "expected #{@obj.name} to have exactly #{expected_count} entries, but has #{@obj_size} instead"
      end
    end
    
end
