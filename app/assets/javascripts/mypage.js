$(function(){
  // --------------出品した商品画面のタブ切り替え--------------
  $(document).on("click",'.exhibition_status', function() {
    $(".exhibition_status.active").removeClass("active");
    $(this).addClass("active");
    $(".exhibition_link.show").removeClass("show");
    var index = $(this).index();
    $('.exhibition_link').eq(index).addClass('show');

    // --------------【実装中】取引中のタブ切り替え--------------
    // if (index == 0) {
    //   var trading_status = 0
    //   $.ajax({
    //     url: "/api/items",
    //     type: 'get',
    //     dataType: 'json',
    //     data: {id: trading_status}
    //   })

    //   .done(function(children) {  
    //     if (children.length !== 0) {
    //       var insertHTML = '';
    //       $.each(children, function(i, child) {
    //         insertHTML += childbuildHTML(child)
    //       });
    //       $('.children__lists').append(insertHTML);
    //     }
    //   })
    // }
    // if (index == 1) {
    // }
    // if (index == 2) {
    // }
    // --------------【実装中】取引中のタブ切り替え--------------
  });

  // --------------購入した商品画面のタブ切り替え--------------
  $(document).on("click",'.purchases_status', function() {
    $(".purchases_status.active").removeClass("active");
    $(this).addClass("active");
    $(".purchases_link.show").removeClass("show");
    var index = $(this).index();
    $('.purchases_link').eq(index).addClass('show');
  });
});