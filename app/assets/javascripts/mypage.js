$(function(){
  // 出品した商品画面のタブ切り替え
  $(document).on("click",'.exhibition_status', function() {
    $(".exhibition_status.active").removeClass("active");
    $(this).addClass("active");
    console.log("クリック");
    $(".exhibition_link.show").removeClass("show");
    var index = $(this).index();
    $('.exhibition_link').eq(index).addClass('show');
  });

  // 購入した商品画面のタブ切り替え
  $(document).on("click",'.purchases_status', function() {
    $(".purchases_status.active").removeClass("active");
    $(this).addClass("active");
    console.log("クリック");
    $(".purchases_link.show").removeClass("show");
    var index = $(this).index();
    $('.purchases_link').eq(index).addClass('show');
  });

  // サイドメニューの選択
  $(document).on("click",'.sidelink', function() {
    $(".sidelink.select").removeClass("select");
    $(this).addClass("select");

    
    console.log("クリック");
    // $(".purchases_link.show").removeClass("show");
    // var index = $(this).index();
    // $('.purchases_link').eq(index).addClass('show');
  });
});