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
    var relationshipId = $(this).data("relationship-id");
    $.ajax({
      method: "delete",
      url: "/relationships/" + relationshipId,
    });
  });
});
