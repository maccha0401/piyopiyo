// piyopiyo
$("#piyo").click(function(){
  $.ajax({
    url: "/knowhows/get_random_knowhow",
    type: "GET",
  }).done(function(data){
    $('.modalContents').html(data);
    $('#modalArea').fadeIn();
  });
});
$('#closeModal , #modalBg').click(function(){
  $('#modalArea').fadeOut();
});
