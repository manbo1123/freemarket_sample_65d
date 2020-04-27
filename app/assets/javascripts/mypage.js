$(function(){
  // --------------出品した商品画面のタブ切り替え--------------
  function exhibitionbuildHTML(exhibition, status_text){
    var html = 
      `
      <li class="exhibiton_list" >
        <div class="exhibition_detail">
          <img class="exhibiton_img" src="${exhibition.img}" ></img>
          <div class="exhibiton_info">
            <p class="exhibiton_name">
            商品名：${exhibition.name}
            </p>
            <p class="exhibition_tag">
            ${status_text}
            </p>
          </div>
        </div>
        <div class="exhibition_btns">
          <a data-method="get" href="/items/${exhibition.id}">
            <button type="button" class="exhibition_btn btn-detail">商品詳細</button>
          </a>
        </div>
      </li>
      `
    return html;
  }
  function shippingbuildHTML(exhibition, status_text){
    var html = 
      `
      <li class="exhibiton_list" >
        <div class="exhibition_detail">
          <img class="exhibiton_img" src="${exhibition.img}" ></img>
          <div class="exhibiton_info">
            <p class="exhibiton_name">
            商品名：${exhibition.name}
            </p>
            <p class="exhibition_tag">
            ${status_text}
            </p>
          </div>
        </div>
        <div class="exhibition_btns">
          <a data-method="get" href="/items/${exhibition.id}">
            <button type="button" class="exhibition_btn btn-detail">商品詳細</button>
          </a>
          <button type="button" data-id="${exhibition.id}" class="exhibition_btn btn-shipping">発送する</button>
        </div>
      </li>
      `
    return html;
  }
  function nonebuildHTML(alert_text){
    var html = 
      `
      <div class="none_links">
        <img class="none_img" src="/assets/logo/logo-white-34b9db297824e9a0b2fe711412f0f6ef6431c163d60f76848bf0c719f656e807.png" alt="Logo white">
          <p class="none_text">
            ${alert_text}
          </p>
        </img>
      </div>
      `
    return html;
  }
  function purchasebuildHTML(purchase, status_text){
    var html = 
      `
      <li class="exhibiton_list" >
        <div class="exhibition_detail">
          <img class="exhibiton_img" src="${purchase.img}" ></img>
          <div class="exhibiton_info">
            <p class="exhibiton_name">
            商品名：${purchase.name}
            </p>
            <p class="exhibition_tag">
            ${status_text}
            </p>
          </div>
        </div>
        <div class="exhibition_btns">
          <a data-method="get" href="/items/${purchase.id}">
            <button type="button" class="exhibition_btn btn-detail">商品詳細</button>
          </a>
          <button type="button" data-id="${purchase.id}" class="exhibition_btn btn-arriving">取引完了</button>
        </div>
      </li>
      `
    return html;
  }

  // --------------出品した商品画面のタブ切り替え--------------
  $(document).on("click",'.exhibition_status', function() {
    $(".exhibition_status.active").removeClass("active");
    $(this).addClass("active");
    $(".exhibition_link").empty();
    var index = $(this).index();
    if (index == 0) { //「出品中」ボタン押下
      var alert_text = "出品中の商品がありません"
      var status_text = "出品中"
      $.ajax({
        url: "/mypage/exhibition/set_exhibition",
        type: 'get',
        dataType: 'json',
        data: {id: index}
      })
      .done(function(exhibition) {  
        var insertHTML = '';
        if (exhibition.length !== 0) {
          $.each(exhibition, function(i, exhibition) {
            insertHTML += exhibitionbuildHTML(exhibition, status_text)
          });
        }else{
          insertHTML += nonebuildHTML(alert_text);
        }
        $(".exhibition_link").append(insertHTML);
      })
    }
    else if (index == 1){ //「取引中」ボタン押下
      var alert_text = "取引中の商品がありません"
      var status_text = '';
      $.ajax({
        url: "/mypage/exhibition/set_exhibition",
        type: 'get',
        dataType: 'json',
        data: {id: index}
      })
      .done(function(exhibition) {  
        var insertHTML = '';
        if (exhibition.length !== 0) {
          $.each(exhibition, function(i, exhibition) {
            console.log(exhibition.trading_status)
            if (exhibition.trading_status == "selling") {
              var status_text = "未発送"
              insertHTML += shippingbuildHTML(exhibition, status_text)
            }else{
              var status_text = "発送済み"
              insertHTML += exhibitionbuildHTML(exhibition, status_text)
            }
          });
        }else{
          insertHTML += nonebuildHTML(alert_text);
        }
        $(".exhibition_link").append(insertHTML);
      })
    }
    else{   //「売却済み」ボタン押下
      var alert_text = "売却済みの商品がありません"
      var status_text = "売却済み"
      $.ajax({
        url: "/mypage/exhibition/set_exhibition",
        type: 'get',
        dataType: 'json',
        data: {id: index}
      })
      .done(function(exhibition) {  
        var insertHTML = '';
        if (exhibition.length !== 0) {
          $.each(exhibition, function(i, exhibition) {
            insertHTML += exhibitionbuildHTML(exhibition, status_text)
          });
        }else{
          insertHTML += nonebuildHTML(alert_text);
        }
        $(".exhibition_link").append(insertHTML);
      })
    };
  })

  // 発送ボタン押下
  $(document).on("click",'.btn-shipping', function(e) {
    e.preventDefault();
    var item_id = $(this).data('id');
    var elm = $(this);
    console.log(item_id);
    $.ajax({
      url: "/mypage/exhibition/shipping",
      type: 'post',
      data: {id: item_id}
    })
    .done(function() { 
      alert("発送処理が完了しました");
      $('.exhibition_tag').text('発送済み');
      elm.remove();
    })
    .fail(function() {
      alert("発送処理が完了できませんでした");
    })
  });

  // --------------購入した商品画面のタブ切り替え--------------
  $(document).on("click",'.purchases_status', function() {
    $(".purchases_status.active").removeClass("active");
    $(this).addClass("active");
    $(".purchases_link").empty();
    var index = $(this).index();
    if (index == 0) {
      var alert_text = "取引中の商品がありません"
    } else {
      var alert_text = "購入済みの商品がありません"
    }
    $.ajax({
      url: "/mypage/purchases/set_purchase",
      type: 'get',
      dataType: 'json',
      data: {id: index}
    })
    .done(function(purchase) {  
      var insertHTML = '';
      var status_text = '';
      if (purchase.length !== 0) {
        $.each(purchase, function(i, purchase) {
          if (purchase.trading_status == "selling") {
            var status_text = "未発送"
            insertHTML += exhibitionbuildHTML(purchase, status_text)
          }else if (purchase.trading_status == "during_deal"){
            var status_text = "発送済み"
            insertHTML += purchasebuildHTML(purchase, status_text)
          }else {
            var status_text = "取引完了"
            insertHTML += exhibitionbuildHTML(purchase, status_text)
          }
        });
      }else{
        insertHTML += nonebuildHTML(alert_text);
      }
      $(".purchases_link").append(insertHTML);
    })
  })

  // 取引完了ボタン押下
  $(document).on("click",'.btn-arriving', function(e) {
    e.preventDefault();
    var item_id = $(this).data('id');
    console.log(item_id);
    var elm = $(this);
    $.ajax({
      url: "/mypage/purchases/arriving",
      type: 'post',
      data: {id: item_id}
    })
    .done(function() { 
      alert("取引が完了しました");
      elm.parent().parent().remove();
    })
    .fail(function() {
      alert("取引が完了できませんでした");
    })
  });

  // --------------サイドメニュー押下時のタブ表示切り替え--------------
  $(window).on("load", function(){
    if(location.pathname == "/mypage/exhibition/selling") {
      $(".exhibition_status").eq(0).addClass("active");
    } else if(location.pathname == "/mypage") {
      $(".exhibition_status").eq(0).addClass("active");
      $(".purchases_status").eq(0).addClass("active");
    } else if(location.pathname == "/mypage/exhibition/dealing") {
      $(".exhibition_status").eq(1).addClass("active");
    } else if(location.pathname == "/mypage/exhibition/closed") {
      $(".exhibition_status").eq(2).addClass("active");
    } else if(location.pathname == "/mypage/purchases/dealing") {
      $(".purchases_status").eq(0).addClass("active");
    } else if(location.pathname == "/mypage/purchases/closed") {
      $(".purchases_status").eq(1).addClass("active");
    }
  });
});