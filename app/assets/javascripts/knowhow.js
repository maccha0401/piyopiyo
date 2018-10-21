// テーブルの行全体をリンクとするための関数
$("tr.knowhow-item-list").click(function(){
  location.href = $(this).find("a").attr("href");
});
