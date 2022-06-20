$(document).ready(function () {
  $(document).on('click', '.btn-reply', function () {
    var courseId = $(this).data("id")
    var parentId = $(this).data("parent-id")
    console.log(parentId)
    console.log(courseId)
    $.ajax({
        method: "get",
        url: "/courses/" + courseId + "/comments/new?parent_id=" + parentId,
    })
  })

  $(document).on('click', '.btn-update', function () {
    var commentId = $(this).data("comment-id")
    console.log(commentId)
    $.ajax({
        method: "get",
        url: "/comments/" + commentId + "/edit",
    })
  })

  $(document).on('click', '.btn_comment', function () {
    var micropostId = $(this).data("id")
    var classCm = ".comment" + "-" + micropostId

    $(classCm).toggle("active");
  })
});