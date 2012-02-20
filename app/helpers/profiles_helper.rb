module ProfilesHelper
  
  def layout_check_boxes profile
    html =''
    rows_data= collect_roles_in_groups
    #puts "bbbb " + collect_roles_in_groups.to_s
    if ! rows_data.empty? then
      html << "<table>"
      rows_data.each { |array|
        html << "<tr>"
        
        html << "<td class='profilerowheader'>"
        if array == rows_data.last then
          html<< t("roles.miscellaneous")  
        else
          arr=array.first.to_s.split("_")
          html << t("roles." + arr[0..(arr.length)-2].join("_"))
        end

        html << "</td>"
        array.each{ |role|
        html << "<td class='profilecheckboxtd'>"
        html << check_box_tag("profile[roles][]", role, profile.roles.include?( role), :class=>"profilecheckbox")
        if array==rows_data.last then
          html << label_tag(role, t("roles." + role.to_s)) #t("."+role.to_s))
        else
          label = role.to_s.split("_").last
          html << label_tag(role, t("roles.actions." + label))
        end
        html << "</td>"
          
        }  
      html << "</tr>\n"
      }
    end
    html<< "</table>"
    return html.html_safe
  end
  
  def collect_roles_in_groups
    #puts Profile.available_roles
    roles=Profile.available_roles.sort{ |r,s |
      r.to_s <=> s.to_s}
    #puts "cccc " + roles.to_s  
    previous_resource=nil
    remember_resource=nil
    all_arrays = []
    current_array = []
    misc_array=[]
    roles.each{ |role|
        split=role.to_s.split('_')
       # puts "dddd " + split.to_s
       # puts"\n"
        #puts split.last
        #puts %w(read write create destroy).include?(split.last)
        #puts "\n"
        role_resource= split[0..(split.length-2)].join('_')
        # puts role_resource
        if %w(read write create destroy).include?(split.last) then
          #puts split.last + " included"
          # "nil " + previous_resource.nil?.to_s
          if role_resource == previous_resource || previous_resource.nil? then
            
            # puts "role rs = prev rs or previs nil " + role.to_s
            add_role_to_array(current_array, split.last, role)
          else
            
            all_arrays << current_array
            current_array = []
            add_role_to_array(current_array, split.last, role)
            # puts "finish " +current_array.to_s
            # puts "all " + all_arrays.to_s 
            
            # current_array << role
            
          end
          previous_resource=role_resource
          #current_array<<role
        else
          #puts "not " + "read write create destroy " +role.to_s
          #puts "rem " + remember_resource.to_s
          #puts "prev " + previous_resource.to_s
          #if remember_resource == role_resource then
            #puts "add extra " + role
            #This is necessary for the case where we have 5 or more roles for 1 resource, e.g location_read, *_write, *_create, *_destroy, *_treeview
            #current_array.insert(4,role)
          #else
            #puts "remember = " +remember_resource.to_s
            #puts "previous = " + previous_resource.to_s
            #puts "remember not = role add to misc " +role.to_s
          role_resource=role
          misc_array << role
            #previous_resource = role
            #remember_resource = role
          #end  
        end  
    }  
    all_arrays<< current_array
    all_arrays << misc_array
    #puts all_arrays
    return all_arrays
  end  
  
  def add_role_to_array array, suffix, role
    if (suffix=='read') then
      array[0] = role
      puts "added read to " +role.to_s
    elsif suffix=="write" then
      array[1] = role 
      puts "added write to " +role.to_s
    elsif suffix=="create" then
      array[2] = role
      puts "added create to " +role.to_s
    elsif suffix=='destroy' then
      array[3] = role   
      puts "added destroy to " +role.to_s  
    end  
  end
end
