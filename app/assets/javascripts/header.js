$(function(){
  // 各カテゴリのリンクを作成
  function childbuildHTML(child){
    var html = 
      `<li>
        <a class="child_link" data-child="${child.id}" data-method="get" href="/items/${child.id}">${child.name}</a>
      </li>
      `
      return html;
  }

  function groundchildbuildHTML(groundchild){
    var html = 
      `<li>
        <a class="groundchild_link" data-groundchild="${groundchild.id}" data-method="get" href="/items/${groundchild.id}">${groundchild.name}</a>
      </li>
      `
      return html;
  }

  // 子要素の枠のmin-heightをルート要素の枠の高さに指定
  var parent_height = $('.parent__lists').height()
  $('.children__lists').css("min-height", parent_height);
  $('.groundchildren__lists').css("min-height", parent_height);

  // 「カテゴリーから探す」にホバーした際にルート要素を表示、ホバー解除の際に非表示
  $('.categorys').hover(function(e){
      e.preventDefault();
      $(".parent__lists").css("display", "block");
    },function(e){
      e.preventDefault();
      $(".children__lists").empty();
      $(".groundchildren__lists").empty();
      $(".parent__lists").css("display", "none");
      $(".children__lists").css("display", "none");
      $(".groundchildren__lists").css("display", "none");
    }
  );
  
  // 各ルート要素にホバーした際に、子要素を表示
  $('.parent_link').mouseover(function(e) {
    e.preventDefault();

    // 子要素を削除
    $(".children__lists").empty();
    $(".groundchildren__lists").empty();
    $(".groundchildren__lists").css("display", "none");
    $(".children__lists").css("display", "block");

    // ルート要素のidを取得しajaxを実行。apiによりidに紐づく子要素を取得
    var parent_id = $(this).data('parent');
    $.ajax({
      url: "/api/items",
      type: 'get',
      dataType: 'json',
      data: {id: parent_id}
    })

    // 子要素のHTML整形。整形したHTMLを.children__listsへ追加・表示
    .done(function(children) {  
      if (children.length !== 0) {
        var insertHTML = '';
        $.each(children, function(i, child) {
          insertHTML += childbuildHTML(child)
        });
        $('.children__lists').append(insertHTML);
      }
    })
  });

  // 子要素にホバーした際、孫要素を表示
  $(document).on("mouseover",'.child_link',function() {
    // 孫要素を削除
    $(".groundchildren__lists").empty();
    $(".groundchildren__lists").css("display", "block");

    // 子要素のidを取得しajaxを実行。apiによりidに紐づく孫要素を取得
    var child_id = $(this).data('child');
    $.ajax({
      url: "/api/items",
      type: 'get',
      dataType: 'json',
      data: {id: child_id}
    })

    // 孫要素のHTML整形。整形したHTMLを.groundchildren__listsへ追加・表示
    .done(function(children) {  
      if (children.length !== 0) {
        var insertHTML = '';
        $.each(children, function(i, groundchild) {
          insertHTML += groundchildbuildHTML(groundchild)
        });
        $('.groundchildren__lists').append(insertHTML);
      }
    })
  });
});