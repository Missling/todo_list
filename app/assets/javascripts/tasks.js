// html page loads first, and the $(document).ready(function{}) tells the js to load only after the html page is done loading to prevent race condition. race condition - when you expect something to go in a certain order and it doesn't. you want html page to load first because js might be targeting element that haven't been loaded yet on the html file. 
$(document).ready(function(){
  $('.new_task').on('submit', function(event){
    event.preventDefault();

    var ajaxRequest = $.ajax({
      dataType: 'json',
      url: $(this).attr('action'),
      type: "POST",
      data: $(this).serialize()
    })

    ajaxRequest.done(function(response){

      var source = $('#entry-template').html()

      var template = Handlebars.compile(source)

      $('table').append(template(response))
    })
  });

  // .delegate() - Attach a handler to one or more events for all elements that match the selector, now or in the future, based on a specific set of root elements.
  // since table will always exist when the file loads, the event handler will always be attached to it
  //another way is $('table').on("click", ".link_delete"
  $('table').delegate(".link_delete", "click", function(event){
  // below is the original code, but it didn't work. when the file loaded, it finds all the .link_delete and adds the event handler. however, when the ajax 'add' appended a new task, the event handler isn't attached to the new task's .link_delete
  // $('.link_delete').on('click', function(event){
    event.preventDefault();
    
    var $this = $(this) 
    var ajaxRequest = $.ajax({
      dataType: 'json',
      url: $this.attr('href'),
      type: "DELETE",
    });

    ajaxRequest.success(function(response){
      console.log($this)
      $this.parents('tr').remove()
    }).fail(function(response){
      console.log("failed")
    });
  });
});





// what happens with a redirect_to root_path with ajax?
// redirect with ajax will result in a fail. since redirect directed back to root_path, it just returns the entire index page html as the response

// what happens without a redirect that the controller doesnt render a json object back?
// resulted in a error saying 'missing template'. this is because rails is looking for a create.html.erb file in the view and was unable to locate it. thus, giving a 500 server error. 

// what happens when there is a render json in the create controller method?
// the create method responds with a json object