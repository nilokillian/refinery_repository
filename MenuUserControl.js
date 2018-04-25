 // https://easthealtheasttrust.sharepoint.com/sites/intranet/_api/SP.UserProfiles.PeopleManager/GetMyProperties
 
 var requestUri = _spPageContextInfo.webAbsoluteUrl + "/_api/SP.UserProfiles.PeopleManager/GetMyProperties"
 var requestHeaders = {"accept" : "application/json;odata=verbose" };

    $.ajax({
        url : requestUri,
        contentType : "application/json;odata=verbose",
        headers : requestHeaders,
        success : onSuccess,
        error : onError
    });

 function onSuccess(data, request){

      var properties = data.d.UserProfileProperties.results;
       for (var i = 0; i < properties.length; i++){
              var property = properties[i];
              if (property.Key == "Association") {
                  var arrayAssociation = property.Value.split("|");
                 //console.log(arrayAssociation)
                var topMenuDropNode = $('.static.dynamic-children.ms-navedit-dropNode');



                $(topMenuDropNode).each(function () {

                    var dropNodeTitle = $(this).attr('title');



                    if ( dropNodeTitle == "GPs" ){

                        

                       var fullLink = $(this).children('ul.dynamic a.dynamic.menu-item.ms-core-listMenu-item.ms-displayInline.ms-navedit-linkNode');



                        console.log(fullLink)



                    }



                    

                });





               // var topMenulinkNode =  $('a.static.dynamic-children.ms-navedit-dropNode.menu-item.ms-core-listMenu-item.ms-displayInline.ms-navedit-linkNode')

               // $(topMenulinkNode).each(function () {



               //        console.log($(this).attr('title'))

              //  });

             

                  var dynamicMenu = $('span.menu-item-text ul.dynamic a.dynamic.menu-item.ms-core-listMenu-item.ms-displayInline.ms-navedit-linkNode')

                  

              

                

                  $(dynamicMenu).each(function () {

  

                      var curentLi = ($(this).attr('title') || '').toString();



                      var found = !!arrayAssociation.find(function(arrayTitle) {

                          return (arrayTitle.toString()) == curentLi.toString();   

                      });

                        if (found == false)

                        {

                          $(this).remove();

                          console.log(curentLi + " Has been removed");

                        }

             

                  });

                                     

              }

          }

      }  

   

  

  



  function onError(error) {

      alert("error");

    }