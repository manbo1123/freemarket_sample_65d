document.addEventListener(
  "DOMContentLoaded", e => {
    Payjp.setPublicKey("pk_test_e9e675c176ceac57450eabed");
    var btn = document.getElementById('token_submit'); //IDがtoken_submitの場合に取得
    btn.addEventListener("click", (e) => {  //ボタンが押されたときに作動
      e.preventDefault();  //ボタンを一旦無効化
      //カード情報生成
      var card = {
        number: $("#number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month").val(),
        exp_year: $("#exp_year").val()
      }; //入力されたデータを取得
      //トークン生成
      Payjp.createToken(card, (status, response) => {
        if (status === 200) { //リクエストが成功した場合
          $("#number").removeAttr("name");
          $("#cvc").removeAttr("name");
          $("#exp_month").removeAttr("name");
          $("#exp_year").removeAttr("name"); //カード情報を自分のサーバにpostせず削除
          $("#card_token").append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); //トークンを送信できるように隠しタグを生成
          document.inputForm.submit();
          alert("登録が完了しました"); 
        } else {
          alert("カード情報が正しくありません。"); 
        }
      });
    });
  },
  false
);