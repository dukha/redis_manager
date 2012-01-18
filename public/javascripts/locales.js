if (!window.I18n) { I18n = {}; }

I18n.defaultLocale = "en";

I18n.translations = {"en":{"date":{"formats":{"default":"%d-%m-%Y","short":"%b %d","long":"%B %d, %Y"},"day_names":["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"],"abbr_day_names":["Sun","Mon","Tue","Wed","Thu","Fri","Sat"],"month_names":[null,"January","February","March","April","May","June","July","August","September","October","November","December"],"abbr_month_names":[null,"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],"order":["year","month","day"]},"time":{"formats":{"default":"%a, %d %b %Y %H:%M:%S %z","short":"%d %b %H:%M","long":"%B %d, %Y %H:%M"},"am":"am","pm":"pm"},"support":{"array":{"words_connector":", ","two_words_connector":" and ","last_word_connector":" and ","skip_last_comma":true}},"errors":{"format":"%{attribute} %{message}","messages":{"inclusion":"is not included in the list","exclusion":"is reserved","invalid":"is invalid","confirmation":"doesn't match confirmation","accepted":"must be accepted","empty":"can't be empty","blank":"can't be blank","too_long":"is too long (maximum is %{count} characters)","too_short":"is too short (minimum is %{count} characters)","wrong_length":"is the wrong length (should be %{count} characters)","not_a_number":"is not a number","not_an_integer":"must be an integer","greater_than":"must be greater than %{count}","greater_than_or_equal_to":"must be greater than or equal to %{count}","equal_to":"must be equal to %{count}","less_than":"must be less than %{count}","less_than_or_equal_to":"must be less than or equal to %{count}","odd":"must be odd","even":"must be even","not_found":"not found","already_confirmed":"was already confirmed","not_locked":"was not locked"}},"activerecord":{"errors":{"messages":{"taken":"%{value} has already been taken","record_invalid":"Validation failed; %{errors}","inclusion":"%{attribute} is not included in the list","exclusion":"%{attribute} is reserved","invalid":"%{attribute} is invalid","confirmation":"%{attribute} doesn't match confirmation","accepted":"%{attribute} must be accepted","empty":"%{attribute} can't be empty","blank":"%{attribute} can't be blank","too_long":"%{attribute} is too long (maximum is %{count} characters)","too_short":"%{attribute} is too short (minimum is %{count} characters)","wrong_length":"%{attribute} is the wrong length (should be %{count} characters)","not_a_number":"%{attribute} with value '%{value}' is not a number. '%{value}' is not a number.","not_an_integer":"%{attribute} with value '%{value}'  must be an integer. '%{value}' is not an integer.","greater_than":"%{attribute} must be greater than %{count}","greater_than_or_equal_to":"%{attribute} must be greater than or equal to %{count}","equal_to":"%{attribute} must be equal to %{count}","less_than":"%{attribute} must be less than %{count}","less_than_or_equal_to":"%{attribute} must be less than or equal to %{count}","odd":"%{attribute} must be odd","even":"%{attribute} must be even"}},"models":{"whiteboard_type":{"one":"Whiteboard Type","other":"Whiteboard Types"},"calmapp":{"zero":"Calm Applications","one":"Calm Application","other":"Calm Applications"},"upload":{"one":"Upload","other":"Uploads"},"version_status":{"one":"Application Version Status","other":"Application Version Statuses"},"calmapp_version":{"one":"Calm Application Version","other":"Calm Application Versions"},"language":{"one":"Translation Language","other":"Translation Languages"},"redis_database":{"one":"Redis Database","other":"Redis Databases"},"redis_instance":{"one":"Redis Instance","other":"Redis Instances"},"translation":{"one":"Translation","other":"Translations"},"translation_parameter":{"one":"Translation Parameter","other":"Translation Parameters"},"user_preference":{"one":"User Preferences","other":"User Preferences"}},"attributes":{"location":{"name":{"world":"Calm World","au-server":"Calm server australia","eu-server":"Calm server europe","australia":"Australia","belgi\u00eb":"Belgium","espa\u00f1a":"Spain"},"type":{"World":"World","Server":"Computer","Area":"Area","Organisation":"Organisation","Venue":"Venue"}},"calmapp":{"new_redis_db":"Add Redis Database","new_version":"Add First Version"},"translation_parameter":{"language_id":"Language","redis_database_id":"Redis Database"},"translation":{"dot_key_code":"Key","translation":"Translation"},"calmapp_version":{"calmapp_id":"Calm App","major_version":"Major Version","version_status_id":"Version Status","languages":"Languages Selected","languages_available":"Languages Available"},"redis_database":{"redis_db_index":"Redis Database Index","calmapp_version_id":"Calm App Version","redis_instance_id":"Redis Instance","redis_database":"Redis Database"},"redis_instance":{"port":"Linux Port","host":"Computer with Database","password":"Password"},"language":{"name":"Translation Language"},"upload":{"upload":"File Name","upload_file_name":"Uploaded File Name","language":"Language"}}},"number":{"format":{"separator":".","delimiter":",","precision":3,"significant":false,"strip_insignificant_zeros":false},"currency":{"format":{"format":"%u%n","unit":"$","separator":".","delimiter":",","precision":2,"significant":false,"strip_insignificant_zeros":false}},"percentage":{"format":{"delimiter":""}},"precision":{"format":{"delimiter":""}},"human":{"format":{"delimiter":"","precision":1,"significant":true,"strip_insignificant_zeros":true},"storage_units":{"format":"%n %u","units":{"byte":{"one":"Byte","other":"Bytes"},"kb":"KB","mb":"MB","gb":"GB","tb":"TB"}},"decimal_units":{"format":"%n %u","units":{"unit":"","thousand":"Thousand","million":"Million","billion":"Billion","trillion":"Trillion","quadrillion":"Quadrillion"}}}},"datetime":{"distance_in_words":{"half_a_minute":"half a minute","less_than_x_seconds":{"one":"less than 1 second","other":"less than %{count} seconds"},"x_seconds":{"one":"1 second","other":"%{count} seconds"},"less_than_x_minutes":{"one":"less than a minute","other":"less than %{count} minutes"},"x_minutes":{"one":"1 minute","other":"%{count} minutes"},"about_x_hours":{"one":"about 1 hour","other":"about %{count} hours"},"x_days":{"one":"1 day","other":"%{count} days"},"about_x_months":{"one":"about 1 month","other":"about %{count} months"},"x_months":{"one":"1 month","other":"%{count} months"},"about_x_years":{"one":"about 1 year","other":"about %{count} years"},"over_x_years":{"one":"over 1 year","other":"over %{count} years"},"almost_x_years":{"one":"almost 1 year","other":"almost %{count} years"}},"prompts":{"year":"Year","month":"Month","day":"Day","hour":"Hour","minute":"Minute","second":"Seconds"}},"helpers":{"select":{"prompt":"Please select"},"submit":{"create":"Create %{model}","update":"Update %{model}","submit":"Save %{model}"}},"meta_search":{"or":"or","predicates":{"equals":"%{attribute} equals","does_not_equal":"%{attribute} doesn't equal","contains":"%{attribute} contains","does_not_contain":"%{attribute} doesn't contain","starts_with":"%{attribute} starts with","does_not_start_with":"%{attribute} doesn't start with","ends_with":"%{attribute} ends with","does_not_end_with":"%{attribute} doesn't end with","greater_than":"%{attribute} greater than","less_than":"%{attribute} less than","greater_than_or_equal_to":"%{attribute} greater than or equal to","less_than_or_equal_to":"%{attribute} less than or equal to","in":"%{attribute} is one of","not_in":"%{attribute} isn't one of","is_true":"%{attribute} is true","is_false":"%{attribute} is false","is_present":"%{attribute} is present","is_blank":"%{attribute} is blank","is_null":"%{attribute} is null","is_not_null":"%{attribute} isn't null"}},"devise":{"failure":{"unauthenticated":"You need to sign in or sign up before continuing.","unconfirmed":"You have to confirm your account before continuing.","locked":"Your account is locked.","invalid":"Invalid email or password.","invalid_token":"Invalid authentication token.","timeout":"Your session expired, please sign in again to continue.","inactive":"Your account was not activated yet."},"sessions":{"signed_in":"Signed in successfully.","signed_out":"Signed out successfully."},"passwords":{"send_instructions":"You will receive an email with instructions about how to reset your password in a few minutes.","updated":"Your password was changed successfully. You are now signed in."},"confirmations":{"send_instructions":"You will receive an email with instructions about how to confirm your account in a few minutes.","confirmed":"Your account was successfully confirmed. You are now signed in."},"registrations":{"signed_up":"You have signed up successfully. If enabled, a confirmation was sent to your e-mail.","updated":"You updated your account successfully.","destroyed":"Bye! Your account was successfully cancelled. We hope to see you again soon."},"unlocks":{"send_instructions":"You will receive an email with instructions about how to unlock your account in a few minutes.","unlocked":"Your account was successfully unlocked. You are now signed in."},"mailer":{"confirmation_instructions":{"subject":"Confirmation instructions"},"reset_password_instructions":{"subject":"Reset password instructions"},"unlock_instructions":{"subject":"Unlock Instructions"}}},"commons":{"noo":false,"yess":true,"next":"Next >>","previous":"<< Previous","no_data":"Nil","for_user":"For User %{user}","search":{"criteria":"Search Criteria","operators":{"from":"From","to":"To","between":"Between","gt":"Greater Than","gte":"Greater than or equals","lt":"Less Than","lte":"Less than or equals","matches":"Contains","does_not_match":"Doesn't' contain","starts_with":"Starts with","ends_with":"Ends with","not_starts_with":"Doesn't start with","not_ends_with":"Doesn't end with","lte_date":"Before","gte_date":"After","in":"In","not_in":"Not in","eq":"Equals","not_eq":"Not Equals","not_null":"Is not empty","is_null":"Is empty","before_something":"Before %{something}","after_something":"After %{something}","and":"and","or":"or"}},"error":{"one":"%{count} error","other":"%{count} errors"},"problem":{"one":"%{count} problem","other":"%{count} problems"}},"formtastic":{"hints":{"user":{"password":"Enter password here","confirm_password":"Enter password again"},"calmapp_version":{"major_version":"Enter the major version here. This is an integer, 1,2,3 or 4 etc","add_languages":"If this checkbox is not checked then no language will be written to the database"},"calmapp":{"name":"Enter the application name.","new_version":"If this checkbox is not checked then no version will be written to the database","new_redis_db":"If this checkbox is not checked then no redis database will be written to the database."},"redis_database":{"host":"Enter the technical name of the computer where the Redis database server is running","port":"Enter the computer port number used by the Redis database.","password":"Enter the actual password for this Redis Instance. If you don't know it then don't add a new record or change an exisitng password."}},"actions":{"sign_in":"Sign In","sign_out":"Sign Out","show":"Show","hide":"Hide","edit":"Edit","destroy":"Delete","delete":"Delete","new":"New","back":"Back to List","create_model":"Add %{model}","save":"Save %{model}","update":"Update %{model}","new_model":"Add %{model}","submit":"Submit","show_something":"Show %{something}","hide_something":"Hide %{something}","mark_deleted":"Mark Deleted","add_child":"Add Child %{location_type}","search":"Search","select":"Select %{model}","create_and_upload":"Create and Upload","to_redis":"Write to Database","redis_to_yaml":"Save Database as YAML"},"labels":{"redis_db_index":"Redis Database Index","port":"Linux Port","host":"Computer with Database","name":"Name","status":"Status","translation":"Translation","translation_file_id_eq":"Translation File equals","max_redis_dbs":"Maximum Number Redis Databases","filter":"Filter"}},"menus":{"admin":"Admin","lookups":"Configuration","user_info":"User Preferences","home":"Home","contact":"Contact Calm","help":"Help","about":"About %{app_name}","whiteboards":"Whiteboards","whiteboard_types":"Whiteboard Types","translations":"Translations","calmapps":"Calm Applications","calmapp_all_in_one_new":"New App, Version, Database","calmapp_versions":"Calm Application Versions","uploads":"Translation Uploads","redis_databases":"Redis Databases","redis_instances":"Redis Instances","languages":"Translation Languages","version_statuses":"Version Statuses","translation_parameters":"Translation Parameters","developers":"Developers","developers_new_translation":"Developers Translation"},"messages":{"delete":{"are_you_sure":{"warning":"Deleting %{model}. Are you sure?"},"are_you_sure_value":{"warning":"Deleting %{model} with value %{value}. Are you sure?"},"success":"The %{model} was successfully deleted.","error:":"The %{model} was not able to be deleted","deletion_rejected":{"error":"Cannot delete this %{model}. It must have other things depending on it (e.g. cannot delete a venue that has courses)"}},"create":{"success":"The %{model} was successfully created.","error:":"The %{model} was not created"},"update":{"success":"The %{model} was successfully updated.","error":"The %{model} was unable to be updated"},"operation":{"error":"Failed to %{operation}  ; %{count_message}."},"no_records_found":{"error":"There were no records found in the database.","warning":"There were no records found in the database."},"no_records_found_with_permissions":{"warning":"There were no records found in the database for which you have permission in the current organisation."},"application_language_change":{"success":"The application language will be changed to %{language} on next refresh or new page."},"capslock_on":{"warning":"You are attempting to type username or password with the capslock on. Remember that username and password are case sensitive."},"record_not_found":{"error":"Unable to find the records to (view, update or delete)"},"non_unique_singlevalue_key":{"error":"%{fieldlist} is already in the database with this value %{valuelist}. Choose a different value to complete this task."},"non_unique_multivalue_key":{"error":"These fields %{fieldlist} are already in the database with these values '%{valuelist}'. Choose at least 1 different value to complete this task."},"existence":{"error":"%{attribute} = %{value}  does not already exist in %{target}. Add a record to  %{target} or choose another %{target} example. "},"permission":{"permission_denied":{"error":"Sorry, you are not allowed to access that page."}},"all_rolledback":{"warning":"All %{model} on this page rolled back"},"array_in_yaml_wrong_format":{"error":"Unsuccessful upload of translation file.\nThis file, %{file_name}, is using incorrect array format.\nChange file format from\n  - array_element1\n  - array_element1\nto\n    key<colon> [array_element1,array_element2..]\nThis problem is around line %{line_number} in the file .\nEdit (or have someone technical  edit) the file and try uploading again.\nDeleted this file from database.\n"},"invalid_email_format":{"error":"Address '%{value}' is not a valid email address for %{attribute}. You can't have spaces and only 1 @"},"invalid_version_format":{"error":"Verson '%{value}' is not a valid format. You can only have digits separated by '.' e.g 7.8.9 or 33.2.04"},"invalid_redis_db_index":{"error":"You have tried to use a redis database number,  %{value}, that is invalid for the current redis installation. If you want to use this number then ask your system admin to increase the number of redis databases."},"invalid_redis_db_location":{"error":"The computer that you have given (= %{value} ) for your Redis database cannot be found. Probably a typo but the computer could also be offline."},"redis_connection_refused":{"error":"The computer that you have given for redis will not accept your connection request. It is possible that the port that you have given (= %{value} ) is incorrect."},"invalid_redis_password":{"error":"The password that your application gave is invalid. The redis password is obtained by the application from the main database via redis_instances. See your system admin for a resolution."},"failed_to_save_file_written_to_redis":{"error":"Could not record save file that was written to Redis database."},"file_already_written_to_redis":{"error":"File '%{file_name}' is already written to redis database for %{redis_name}."},"translation_parameters_not_set":{"warning":"Before doing this you must set the translation parameters"},"file_to_redis":{"success":"Successfully written the contents of %{file} to redis."},"create_translation":{"success":"Sucessfully created translation for '%{code}' = '%{translation}'.","error":"Failed to create '%{code}' = '%{translation}'. "},"create_relationaldb_redis":{"success":"Sucessfully created translation for '%{code}' in both redis and relational database.","warning":"Failed to create '%{code}'  in redis. "},"are_you_sure":{"all_translations_also_deleted":{"warning":"Are you sure that you want to delete this file from the database?\nAll translations in this file will also be deleted (from the database).\n"}}},"links":{"no_unlock_instructions":"Didn't receive unlocking instructions?","no_confirmation_instructions":"Didn't receive confirmation instructions?","forgotten_password":"Forgot your password?","cancel_registration":"Cancel account","unhappy":"Unhappy?"},"headings":{"new":{"heading":"Add %{model}","user":"Register New User"},"edit":{"heading":"Edit %{model}","user":"Edit User"},"listing":{"heading":"%{model}"},"home":{"heading":"Home - Whiteboard"},"application_subheading":"Calm Translator M1","write_to_database":{"heading":"Write File Contents to %{model}"},"translation_parameters":{"heading":"Translation Parameters"}},"lookups":{"whiteboard_type":{"system":"System","localadmin":"Local Admin","regionaladmin":"Regional Admin","user":"User"}},"activemodel":{"errors":{"template":{"header":{"one":"1 error prohibited this %{model} from being saved","other":"%{count} errors prohibited this %{model} from being saved"},"body":"There were problems with the following fields:"}}}}};

(function(){

  var interpolatePattern = /%\{([^}]+)\}/g;

  //Replace %{foo} with obj.foo
  function interpolate(str, obj){
    return str.replace(interpolatePattern, function(){
      return typeof obj[arguments[1]] == 'undefined' ? arguments[0] : obj[arguments[1]];
    });
  };

  //Split "foo.bar" to ["foo", "bar"] if key is a string
  function keyToArray(key){
    if (!key) return [];
    if (typeof key != "string") return key;
    return key.split('.');
  };

  function locale(){
    return I18n.locale || I18n.defaultLocale;
  };

  function getLocaleFromCookie(){
    var cookies = document.cookie.split(/\s*;\s*/),
        i, pair, locale;
    for (i = 0; i < cookies.length; i++) {
      pair = cookies[i].split('=');
      if (pair[0] === 'locale') { locale = pair[1]; break; }
    }
    return locale;
  };


  I18n.init = function(){
    this.locale = getLocaleFromCookie();
  };

  //Works mostly the same as the Ruby equivalent, except there are
  //no symbols in JavaScript, so keys are always strings. The only time
  //this makes a difference is when differentiating between keys and values
  //in the defaultValue option. Strings starting with ":" will be considered
  //to be keys and used for lookup, while other strings are returned as-is.
  I18n.translate = function(key, opts){
    if (typeof key != "string") { //Bulk lookup
      var a = [], i;
      for (i=0; i<key.length; i++) {
        a.push(this.translate(key[i], opts));
      }
      return a;
    } else {
      opts = opts || {};
      opts.defaultValue = opts.defaultValue || null;
      key = keyToArray(opts.scope).concat(keyToArray(key));
      var value = this.lookup(key, opts.defaultValue);
      if (typeof value != "string" && value) value = this.pluralize(value, opts.count);
      if (typeof value == "string") value = interpolate(value, opts);
      return value;
    }
  };

  I18n.t = I18n.translate;

  //Looks up a translation using an array of strings where the last
  //is the key and any string before that define the scope. The current
  //locale is always prepended and does not need to be provided. The second
  //parameter is an array of strings used as defaults if the key can not be
  //found. If a key starts with ":" it is used as a key for lookup.
  //This method does not perform pluralization or interpolation.
  I18n.lookup = function(keys, defaults){
    var i = 0, value = this.translations[locale()];
    defaults = typeof defaults == "string" ? [defaults] : (defaults || []);
    while (keys[i]) {
      value = value && value[keys[i]];
      i++;
    }
    if (value){
      return value;
    } else {
      if (defaults.length == 0) {
        return null;
      } else if (defaults[0].substr(0,1) == ':') {
        return this.lookup(keys.slice(0,keys.length-1).concat(keyToArray(defaults[0].substr(1))), defaults.slice(1));
      } else {
        return defaults[0];
      }
    }
  };

  I18n.pluralize = function(value, count){
    if (typeof count != 'number') return value;
    return count == 1 ? value.one : value.other;
  };

})();

I18n.init();
