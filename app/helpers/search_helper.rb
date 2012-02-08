module SearchHelper
   def all_operators
     %w(eq str_eq not_eq str_not_eq matches does_not_match gt gte gte_date lt lte lte_date in not_in str_in str_not_in is_null not_null)
   end
   def all_operators translated = nil
       ar = all_operators 
      if translated then
        return translate_operators ar 
      else 
        return ar  
      end
     
    end
    
    def equal_operator translated = nil
      ar = %w(eq) 
      if translated then
        return translate_operators ar
      else 
        return ar  
      end
    end
    
    def compare_operators translated = nil
      ar = %w(eq not_eq gt gte lt lte)
      if translated then
       return translate_operators ar
      else 
        return ar  
      end
    end
    
    def date_operators translated = nil
      ar = %w(gte_date lte_date)
      if translated then
        return translate_operators ar 
      else 
        return ar  
      end
    end
=begin   
    def operators_to_options array#, options={}
      texts = translate_operators array
      values= array
      #options =[]
      options=''
      i=0
      array.each{|op| 
        options << "<option value='"+ values[i] + "'>" + texts[i] + "</options>\n"
        i=+1
      }
      return options.html_safe
    end 
=end    
     def operators_2_options array#, options={}
      texts = translate_operators array
      values= array
      options =[]
      i=0
      array.each{|op| 
        options.push([texts[i], values[i]])
        i += 1
      }
      return options
    end
      
    def string_operators translated = nil
      ar = %w(eq not_eq begins_with ends_with matches does_not_match in not_in is_null not_null)
      if translated then
        return translate_operators ar 
      else 
        return ar  
      end
    end
    
    def translate_operators ar
       arx=[]
       #debugger
       ar.each{|op| arx.push(I18n.t("commons.search.operators." +op))}
       return arx
    end
    
    def squeel_operator op
      operators = {"eq"=>"==", "not_eq"=>"!=", "matches"=>"=~", "does_not_match"=>"!~", "gt"=>">", "gte"=>">=", "lt"=>"<", "lte"=>"<=", "in"=>">>", "not_in" => "<<", "is_null" => "== nil", "not_null"=>"!= nil"}
      return operators[op]
    end
=begin    
    def ui_2_squeel model, attr,  operator='eq', data1=nil, data2=nil
      sq_op = squeel_operator(operator)
      model.where{venue_id my{sq_op} my{data1}}
    end
=end
  
  # usuage sort on main model or single model with no joins select: sortable(:end_date, "course")
  # usage sort on a belongs_to Course belongs_to :course_type  Course.course_type_id is the tranlation key to use for display 
  # but sort using course_type.translation_code: sortable("course_types.translation_code","course", "course_type_id")
  # A trickier example of a belongs_to: Venue < Location, so to reference venues.name you have to use locations.name 
  # (Note the plurals used in course_types.translation_code and locations.name) 
  # usage: sortable("locations.name","course","venue_id")
  def sortable(column_to_sort_by, model, translation_code = nil)  
    #debugger
    header  = translation_code.nil? ? tlabel(column_to_sort_by.to_s, model) : tlabel(translation_code, model) 
    direction = (column_to_sort_by.to_s == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"    
    link_to header, params.merge(:sort => column_to_sort_by, :direction => direction)
  end 
end