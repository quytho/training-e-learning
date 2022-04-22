$(document).ready(function () {
  $(document).on("click", ".btn-follow", function () {
    var followedId = $(this).data("followed-id");
    $.ajax({
      method: "post",
      url: "/relationships",
      data: { id: followedId },
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
  })
  // Done word
  $(document).on('click', '.btn-done', function () {
    var wordId = $(this).data("word-id")
    var userId = $(this).data("user-id")
    $.ajax({
      method: "post",
      url: "/user_word",
      data: { word_id: wordId, user_id: userId, is_learned: true }
    })
  })
  // Get all - learn - unlearn 
  $(document).on('click', '.btn-get-all', function () {
    if ($('.get-all-unlearn').length) {
      $('.get-all-unlearn').removeClass("active-get-all")
    }
    $('.get-all-learned').removeClass("active-get-all")
    $('.get-all').removeClass("unactive-get-all")
  })

  $(document).on('click', '.btn-get-learned', function () {
    if ($('.get-all-unlearn').length) {
      $('.get-all-unlearn').removeClass("active-get-all")
    }
    $('.get-all-learned').addClass("active-get-all")
    $('.get-all').addClass("unactive-get-all")
  })

  $(document).on('click', '.btn-get-unlearn', function () {
    if ($('.get-all-learned').length) {
      $('.get-all-learned').removeClass("active-get-all")
    }
    $('.get-all-unlearn').addClass("active-get-all")
    $('.get-all').addClass("unactive-get-all")
  })
  // Sound-word
  $(document).on("click", ".btn-sound", function () {
    var word = $(this).data("word");
    var msg = new SpeechSynthesisUtterance();
    voices = speechSynthesis.getVoices();
    msg.text = word;
    msg.rate = 0.7;
    speechSynthesis.speak(msg);
  });
});
