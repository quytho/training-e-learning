$(document).ready(function () {
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
});
