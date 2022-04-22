$(document).ready(function () {
  $(document).on('submit', '#form_practice', function (e) {
    e.preventDefault();
    $('.btn-submit').attr('disabled', true);
    const answers = $(this).serializeArray();
    const lesson_id = $('#form_practice').data('lesson');

    $.ajax({
      type: 'GET',
      url: '/learning/get-word',
      dataType: 'json',
      data: { lesson_id: lesson_id },
      success: function (result) {
        let score = compareAnswers(answers, result);
        postPractice(score, lesson_id);
      },
    });
  });
});

function compareAnswers(answers, result) {
  let score = 0;
  answers.forEach((answer, index) => {
    let currentInput = $(`input[name='ans_${index + 1}']`);
    if (answer.value.toLowerCase() === result[index].en_word.toLowerCase()) {
      currentInput.addClass('is-valid');
      score++;
    } else {
      currentInput.addClass('is-invalid');
      currentInput
        .parent()
        .append(
          `<div class="invalid-feedback">${result[
            index
          ].en_word.toLowerCase()}</div>`
        );
    }
  });

  return score;
}

function postPractice(score, lesson_id) {
  $.ajax({
    type: 'POST',
    url: '/practice',
    data: { score: score, lesson_id: lesson_id },
  });
  $('#form_practice').before(`<div class='alert alert-success'>
    <h4 class="alert-heading">Well done!</h4>
    <p>Your score is ${score * 10}</p>
    <div class="d-flex">
      <a class="btn btn-primary" href="/learning?lesson_id=${
        lesson_id + 1
      }">Next lesson</a>
    </div>
  </div>`);
}
