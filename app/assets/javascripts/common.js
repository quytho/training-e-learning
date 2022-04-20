$(document).ready(function () {

  $(document).on('click', '.btn-words-list-item', function () {
    var word = $(this).data("id")
    var classWord = ".info_word-list" + "-" + word;
    $(classWord).addClass("active");
  })
  $(document).on('click', '.word_list-close', function () {
    var word = $(this).data("id")
    var classWord = ".info_word-list" + "-" + word;
    $(classWord).removeClass("active");
   })

  // register the course
  $(document).on('click', '.btn-register', function () {
    var courseId = $(this).data("course-id")
    var userId = $(this).data("user-id")
    $.ajax({
      method: "post",
      url: "/user_course",
      data: { course_id: courseId, user_id: userId }
    })
  })

  $(document).on("change", "#word_course_id", function(){
    var course_id = $(this).val();
    $.ajax({
      url: "/admin/words/new",
      method: "GET",
      dataType: "json",
      data: {course_id: course_id},
      error: function (xhr, status, error) {
        console.error('AJAX Error: ' + status + error);
      },
      success: function (response) {
        console.log(response);
        var lessons = response["lessons"];
        $("#lesson select").empty();
        $("#lesson select").append('<option>Select lesson</option>');
        for(var i=0; i< lessons.length; i++){
          $("#lesson select").append('<option value="' + lessons[i]["id"] + '">' + lessons[i]["name"] + '</option>');
        }
      }
    });
  });
});
