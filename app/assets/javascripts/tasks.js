$(document).ready(function(){

  $('.new_task').submit(function(event){
    event.preventDefault();

    var ajaxRequest = $.ajax({
      dataType: 'json',
      url: $(this).attr('action'),
      type: "POST",
      data: $(this).serialize()
    })

    ajaxRequest.done(function(response){
      console.log(response)
    })
    ajaxRequest.fail(function(response){
      console.log('failure')
    });
  });
});

// what happens with a redirect_to root_path with ajax?
// redirect with ajax will result in a fail. since redirect directed back to root_path, it just returns the entire index page html as the response

// what happens without a redirect that the controller doesnt render a json object back?
// resulted in a error saying 'missing template'. this is because rails is looking for a create.html.erb file in the view and was unable to locate it. thus, giving a 500 server error. 

// what happens when there is a render json in the create controller method?
// the create method responds with a json object