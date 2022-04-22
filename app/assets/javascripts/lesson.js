$(document).ready(function () {
  $(document).on("click", ".btn-sound", function () {
    var word = $(this).data("word");
    var msg = new SpeechSynthesisUtterance();
    voices = speechSynthesis.getVoices();
    msg.text = word;
    msg.rate = 0.7;
    speechSynthesis.speak(msg);
  });
});
