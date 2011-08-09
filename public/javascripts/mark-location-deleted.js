<script type ="text/javascript">
            /*This script allows the user to mark a location as deleted*/
            
            $("a.markLocationDeleted").click(function(){
              var dbId = this.attr("title");
              //var dbId = href.split("/").last();
           
              $.ajax({
                url:         "<%=mark_location_deleted_path  %>",
                type:        "DELETE",
                dataType:    "json",
                data:        {id: dbId},
                success:     function(){
                               alert("Update complete");
                             },
                failure:     function(){
                               alert("update failure");
                             }

              }); //end ajax
              return false;
            });  //end click
            $(selectList).change(function(){
               var isoCode= $(selectList).val();
               var newLanguage = $(selectList + ' option:selected').text();
               //alert("<%= change_application_language_path %>");
               $.ajax( {
                       url:        "<%= change_application_language_path %>",
                       type:       "GET",
                       dataType:   "json",
                       data:       { iso_code:  isoCode },
                       complete:    function() {
                                       //This function is not needed
                                    },
                       success:    function(data, textStatus, xhr)   {
                                        //t( ) from babilu gem
                                        //alert(I18n.t("messages.application_language_change.success", {language: newLanguage}));
                                        // @todo the above code needs to be rewritten inr ruby
                                        path = window.location.pathname;
                                        paths =path.split("/");
                                        if(paths[1] == 'users'){
                                          paths.splice(1,0,isoCode);
                                        }else{
                                          paths[1] = isoCode; // do this on 2nd lement as first is ""
                                        }
                                        newPath = paths.join("/");
                                        newURL = window.location.protocol + "//" + window.location.host +  newPath;
                                        window.location.href = newURL;
                                        window.location.reload;



                                    },
                      error:      function(request, status, error) {
                                    //This callback will handle errors on the server but not errors in the success callback
                                    //@todo put the reponse text in a web page
                                    alert(request.responseText);
                                  },
                     });//end ajax


            });

        </script>


