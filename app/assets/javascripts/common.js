$(document).ready(function () {
  $(document).on("click", ".btn-follow", function () {
    var followedId = $(this).data("followed-id");
    $.ajax({
      method: "post",
      url: "/relationships",
      data: { followed_id: followedId },
    });
  });
  $(document).on("click", ".btn-unfollow", function () {
    var followedId = $(this).data("followed-id");
    $.ajax({
      method: "delete",
      url: "/relationships/" + followedId,
    });
  });
  
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
  });
});
