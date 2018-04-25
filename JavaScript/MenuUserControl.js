 // https://easthealtheasttrust.sharepoint.com/sites/intranet/_api/SP.UserProfiles.PeopleManager/GetMyProperties
 
 var requestUri = _spPageContextInfo.webAbsoluteUrl + "/_api/SP.UserProfiles.PeopleManager/GetMyProperties"
 var requestHeaders = {"accept" : "application/json;odata=verbose" };
 var arrayAssociation;
    $.ajax({
        url : requestUri,
        contentType : "application/json;odata=verbose",
        headers : requestHeaders,
        success : onSuccess,
        error : onError
    });
/////////////////////////

var test;

 function onSuccess(data, request){
      var properties = data.d.UserProfileProperties.results;
           for (var i = 0; i < properties.length; i++){
              var property = properties[i];
              if (property.Key == "Association"){
                  arrayAssociation = property.Value.split("|");
                  getMenuNodes();
                 //console.log(arrayAssociation)
                }
            }
    }

  function getMenuNodes(){
        $('ul#zz12_RootAspMenu.root.ms-core-listMenu-root.static').find('li').each(function(){
           $(this).find('.static.dynamic-children').each(function(){ 
                if ($(this).attr('title') == "GPs"){ 
                    $('a.dynamic.menu-item.ms-core-listMenu-item.ms-displayInline.ms-navedit-linkNode').each(function(){
                    //console.log($(this).attr('title'));
                    $(this).each(function(){
                        var curentLi = ($(this).attr('title') || '').toString();
                        var found = !!arrayAssociation.find(function(arrayTitle){
                        return (arrayTitle.toString()) == curentLi.toString();   
                        });       
                 
                            if (found == false){
                               //$(this).remove();
                                console.log(curentLi + " Has been removed");
                            } 

                        
                        });
                    }); 
                }
            });         
        });
    }  

  function onError(error) {

      alert("error");

    }