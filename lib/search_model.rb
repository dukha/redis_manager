module SearchModel
  
  def build_lazy_loader ar_relation, criteria ={},  operators= {}
    criteria.each { |k,v|
       attr= 'squeel.' + k
      if operators[k]== 'eq'  then
        ar_relation= ar_relation.where{|squeel| eval(attr) ==  v }
      elsif operators[k] == 'not_eq'  then       
        ar_relation= ar_relation.where{|squeel| eval(attr) !=  v }
      elsif operators[k]  == 'lte_date' || operators[k]  == 'lte' then
        ar_relation= ar_relation.where{|squeel| eval(attr) <=  v }
      elsif operators[k]  == 'gte_date' || operators[k]  == 'gte' then
        ar_relation= ar_relation.where{|squeel| eval(attr) >=  v }
      elsif operators[k]  == 'lt' then
        ar_relation= ar_relation.where{|squeel| eval(attr) <  v }
      elsif operators[k]  == 'gt' then
        ar_relation= ar_relation.where{|squeel| eval(attr) >  v }
      elsif operators[k]  == 'matches' then
        ar_relation= ar_relation.where{|squeel| eval(attr) =~ '%' + v + '%' } 
      elsif operators[k]  == 'does_not_match' then
        ar_relation= ar_relation.where{|squeel| eval(attr) !~ '%' + v + '%' }
      elsif operators[k] == 'begins_with'  then   
        ar_relation= ar_relation.where{|squeel| eval(attr) =~ v + '%' }
      elsif operators[k] == 'ends_with'  then 
        ar_relation= ar_relation.where{|squeel| eval(attr) =~ '%' + v }
      elsif operators[k] == 'is_null'  then        
        ar_relation = ar_relation.where{ |squeel| eval(attr) == nil}
      elsif operators[k] == 'not_null'  then        
        ar_relation = ar_relation.where{ |squeel| eval(attr) != nil}
      elsif operators[k] == 'in'  then 
        ar_relation = ar_relation.where{ |squeel| eval(attr) >> v}
      elsif operators[k] == 'not_in'  then 
        ar_relation = ar_relation.where{ |squeel| eval(attr) << v}        
      end
    }
    return ar_relation
  end
  
end