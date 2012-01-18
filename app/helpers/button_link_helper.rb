module ButtonLinkHelper
 
  # emit html for n link headers
  def link_header n
    html = " "
    n.times { html += '<th class="linkheader"></th>' }
    html.html_safe
  end

  # link_edit edit_course_type_path(course_type) if permitted_to? :update, :course_types
  def link_apply url, resource, options={}
    html = ""
    if permitted_to? :update, make_resource(resource)
      html = "<td class='link'>"+tlink_to("apply",url,{:target=>"_blank", :category=>:action})+"</td>"
    end
    html.html_safe
  end


  # link_display display_public_schedule_path(public_schedule),  :public_schedules
  def link_display url, resource, options={}
    html = " "
    if permitted_to? :display, make_resource(resource)
      html =  "<td class='link'>"+ 
        tlink_to("display", url, options)+
        "</td>"
    end
    html.html_safe
  end
  
  # link_edit edit_course_type_path(course_type) if permitted_to? :update, :course_types
  # <td class='link'><a href="/de/course_types/26/edit">Bearbeiten</a></td>
  def link_edit url, resource, options={}
     html = " "
     #debugger
    if permitted_to? :update, make_resource(resource)
      html = "<td class='link'>"+ 
        tlink_to("edit", url)+
        '</td>'
    end
    html.html_safe
  end
 
  # link_destroy course_type, :course_types
  # <td class='link'><a href="/de/course_types/31" data-confirm="Sind Sie sicher?" data-method="delete" rel="nofollow">Löschen</a></td>
  def link_destroy obj, resource, options={}
     html = " "
     if permitted_to? :destroy, make_resource(resource)
        if options[:confirm].nil? then
          options[:confirm] = 'delete.are_you_sure'
        end
        if options[:model].nil? then
          options[:model]= make_model(obj.class.name)
        end
        if options[:count].nil? then
          options[:count]=1
        end
        options[:method] = :delete    
        html = "<td class='link'>"+ 
          tlink_to("destroy", obj,
            options)+
          '</td>'
     end
    html.html_safe
  end

  def link_new url, resource, options={}
     html = " "
     #debugger
     if options[:model].nil? then
          options[:model]= make_model(resource)
     end
     if options[:count].nil? then
          options[:count]=1
     end
     if permitted_to? :create, make_resource(resource) then
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
  def link_menu(resource, options={})
    html=' '
    if permitted_to? :index, make_resource(resource) then
      if resource.is_a? Symbol then
        model_plural = resource.to_s
      else
        model= make_model( resource).pluralize  
      end
      html = "<li class='menuItem'>" + link_to(tmenu(model_plural), eval(model_plural + "_path"), options) + "</li>"
    end
    #ebugger
    return html.html_safe
  end
  # x can be :course_types  :course_type  :CourseType  :CourseTypes or analogous string or :CourseType or :CourseTypes
  # works also for person - people
  # returns :course_types
  def make_resource x
    if x.is_a? Symbol then
      return x
    else
      return x.to_s.tableize.to_sym
    end
  end

  # x can be :course_types  :course_type  :CourseType  :CourseTypes or analogous string or :CourseType or :CourseTypes
  # returns "course_type"
  # works also for person - people
  def make_model x
    x.to_s.tableize.singularize
  end

 
end