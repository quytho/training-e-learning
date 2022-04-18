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
});
