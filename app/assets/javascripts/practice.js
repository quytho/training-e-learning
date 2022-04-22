$(document).ready(function () {
  $(document).on("submit", "#form_practice", function (e) {
    e.preventDefault();
    $(".btn-submit").attr("disabled", true);
    let replies = $(this).serializeArray();
    let lesson_id = $("#form_practice").data("lesson");

    let score = 0;
    $.ajax({
      type: "GET",
      url: "/lesson/get-word",
      dataType: "json",
      data: { lesson_id: lesson_id },
      success: function (result) {
        replies.forEach((reply, index) => {
          let currentInput = $(`input[name='ans_${index + 1}']`);
          if (reply.value.toLowerCase() === result[index].en_word.toLowerCase()) {
            currentInput.addClass("is-valid");
            score++;
          } else {
            currentInput.addClass("is-invalid");
            currentInput.parent().append(`<div class="invalid-feedback">${result[index].en_word.toLowerCase()}</div>`);
          }
        });

        $.ajax({
          type: "POST",
          url: "/practice",
          data: { score: score, lesson_id: lesson_id },
        });
        $("#form_practice").before(`<div class='alert alert-success'>
          <h4 class="alert-heading">Well done!</h4>
          <p>Your score is ${score * 10}</p>
          <div class="d-flex">
            <a class="btn btn-primary" href="/learning?lesson_id=${lesson_id + 1}">Next lesson</a>
          </div>
        </div>`);
      },
    });
  });
});
