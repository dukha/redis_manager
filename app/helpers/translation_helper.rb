module TranslationHelper
  def get_translation_parameters
    tp =  TranslationParameter.new
    #debugger
    tp.language_id = cookies[:translation_language_id]
    tp.redis_database_id= cookies[:current_redis_database_id]
    return tp
  end

  def get_redis_connection
    tp = get_translation_parameters
    return RedisDatabase.find(tp.redis_database_id).connect

  end
=begin
  def erb_translation_object dot_key
    if dot_key.nil? then
      return :string
    elsif dot_key.index('message') then
      return :text
    else
      return :string
    end
  end
=end
  def dot_key_array
    return ['label', 'label and hint','message','message error', 'message info','message success','message warning','model','model and menu','action', 'lookup']
  end
  
  def dot_key_helper
    arr = []
    i=0
    dot_key_array.each do |k|
      arr << [k, i]
      i += 1
    end
    return arr
  end

  def helper_to_dot_key selected_index, model=nil, iso_code= 'en'
    ret_val = []
    iso_code += '.'
    ret_val[0] = iso_code
    case selected_index
      when '0'
        ret_val[0] += $ARA

      when '1'
        ret_val[0] += $ARA
        ret_val[1] = iso_code + $FH
      when '2'
        ret_val[0] += $MS
      when '3'
        ret_val[0] += $MSE
      when '4'
        ret_val[0] += $MSN

      when '5'
        ret_val[0] += $MSS
      when '6'
        ret_val[0] += $MSW
      when '7'
        ret_val[0] += $ARM + model + ".one"
        ret_val[1] = iso_code + $ARM + model + ".other"
      when '8'
       ret_val[0] += $ARM + model + ".one"
       ret_val[1] = iso_code + model + ".other"
       ret_val[2] = iso_code + $M +model
      when '9'
       ret_val[0] += $FA
      when '10'
        ret_val[0] += $LU + model
        ret_val[1] = iso_code + $LU +'.description.'
    end
    return rev_val
  end
  
  #This is just for display: Move to Helper
  def dot_key_code_wrapped dot_key_code
    if dot_key_code.nil? || dot_key_code.length < 20 then
      return dot_key_code
    else
      arr= dot_key_code.split('.')
      chars=0
      sep = '.'
      str = nil
      #puts 'a:' + arr.to_s
      arr.each do |part|
        #debugger
        #puts 'p:' + part
        chars += part.length
        if chars > 20 then
          sep='.<br>'
          chars =0
        end
        #puts 'c:' + chars.to_s
        if str.nil? then
          str = part
        else
          str += (sep + part)
        end
        #puts 's:' + str
      end
        #puts 'se:' + str
        return str.html_safe
      #line = dot_key_code[20..(dot_key_code.length - 1)]
      #index = line.replace( line.index('.')
    end
  end
  
  def dot_key_code_last_key dot_key_code
    return dot_key_code.split('.').last
  end
  def dot_key_code_no_lang dot_key_code
    arr = dot_key_code.split('.')
    return arr[1..(arr.length-1)].join('.')
  end
end
