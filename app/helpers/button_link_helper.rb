module ButtonLinkHelper
   include Search
  # emit html for n link headers
  def link_header n
    html = " "
    n.times { html += '<th class="linkheader"></th>' }
    html.html_safe
  end

  # link_edit edit_course_type_path(course_type) if permitted_to? :update, :course_types
  def link_apply url, resource, options={}
    html = ""
    if permitted_to? :update, table_symbol_from(resource)
      html = "<td class='link'>"+tlink_to("apply",url,{:target=>"_blank", :category=>:action})+"</td>"
    end
    html.html_safe
  end


  # link_display display_public_schedule_path(public_schedule),  :public_schedules
  def link_display url, resource, options={}
    html = " "
    if permitted_to? :display, table_symbol_from(resource)
      html =  "<td class='link'>"+ 
        tlink_to("display", url, options)+
        "</td>"
    end
    html.html_safe
  end
  
 # Usage : <%= link_edit edit_course_type_path(course_type), :course_types  %>
 #Usage in dropdown menu : <%=link_edit(edit_course_path(course), :courses, {:category=>'menu'}, 'li' )%> 
  def link_edit url, resource, options={}, html_container='td'
     html = " "
     #debugger
    if permitted_to? :update, table_symbol_from(resource)
      a =  tlink_to("edit", url, options)
      #debugger
      html = wrap_in_html_container(a, html_container, 'link')
    end
    html.html_safe
  end
 
  # link_destroy course_type, :course_types
  # <td class='link'><a href="/de/course_types/31" data-confirm="Sind Sie sicher?" data-method="delete" rel="nofollow">Löschen</a></td>
  # Usage in dropdown menu : <%=link_destroy(course, :courses, {:category=>'menu'}, 'li') %> 
  def link_destroy obj, resource, options={}, html_container='td'
     html = " "
     #debugger
     if permitted_to? :destroy, table_symbol_from(resource)
        if options[:confirm].nil? then
          options[:confirm] = 'delete.are_you_sure.warning'
        end
        if options[:model].nil? then
          options[:model]= singular_table_name_from(obj.class.name)
        end
        #if options[:count].nil? then
          #options[:count]=1
        #end
        options[:method] = :delete   
        a= tlink_to("destroy", obj, options) 
        #debugger
        html = wrap_in_html_container(a, html_container, 'link')
     end
    html.html_safe
  end
  
  def wrap_in_html_container html, container, klass='link'
    return  "<" + container + " class='" + klass +"'>" +html +"</" +container +">"
  end
  
   
  def link_new url, resource, options={}
     html = " "
     #debugger
     if options[:model].nil? then
          options[:model]= singular_table_name_from(resource)
     end
     if options[:count].nil? then
          options[:count]=1
     end
     if permitted_to? :create, table_symbol_from(resource) then
       html =  tlink_to( "new_model", url, options )
     end
    html.html_safe
  end
 
  def link_back(url, options={})
    
    html=' '
    html = tlink_to('formtastic.actions.back', url, options)
    return html.html_safe
    
  end 
  # this doesnt lin in with search button. Need deprecation
  def link_sort_header(column_translation_code )
    #title ||= column.titleize
    if column_translation_code.index('.') then
      column=column_translation_code.split.last
    else
      column=column_translation_code
    end
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    # need to add back the sqlinjection protection here
    #css_class =  "current #{sort_direction}" 
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to tlabel(column_translation_code), {:sort => column, :direction => direction}, {:class => css_class}
  end
  # creates a link to the index page of the resource
  # @todo needs to have url optional param added
  # usage: <%=link_menu(:languages)%>
  def link_menu(resource, options={})
    html= ' '
    if permitted_to? :index, table_symbol_from(resource) then
      if resource.is_a? Symbol then
        model_plural = resource.to_s
      else
        model= singular_table_name_from( resource).pluralize  
      end
       a = link_to(tmenu(model_plural), eval(model_plural + "_path"), options) 
       html = wrap_in_html_container a, 'li', 'menuItem'
    end
    #ebugger
    return html.html_safe
  end
  # x can be :course_types  :course_type  :CourseType  :CourseTypes or analogous string or :CourseType or :CourseTypes
  # works also for person - people
  # returns :course_types
  # see examples in spec/helpers/button_link_helper_spec.rb
  def table_symbol_from x
    x.to_s.tableize.to_sym
  end

  # x can be :course_types  :course_type  :CourseType  :CourseTypes or analogous string or :CourseType or :CourseTypes
  # returns "course_type"
  # works also for person - people
  # see examples in spec/helpers/button_link_helper_spec.rb
  def singular_table_name_from x
    x.to_s.tableize.singularize
  end

 
end
