$(function () {
  $(".current").first().addClass("active"); // 1枚目の小画像をアクティブに変更
  $('.image-small').click(function () { // 小画像がクリックされたらイベント発火
    image_url = $(this).attr('src'); // クリックされた画像のPATHを取得
    $(".image-big").attr('src', image_url).hide().fadeIn(); 
    $(".current.active").removeClass("active"); // 1枚目の小画像のアクティブを無効化
    $(this).parent().addClass("active"); // クリックされた小画像をアクティブに変更
  });
});