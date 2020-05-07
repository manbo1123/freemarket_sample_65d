//----------------------------ページ更新で表示-------------------------------//
window.onload = function () {
  //画像削除用のチェックボックス
  $('.hidden-destroy').hide();
  //保存済み画像数に応じて変更
  let image_num = $('.preview').length;
  if (image_num >= 5) {
    $('.item_imgs').css('display', 'none');
    $('.under_group').css('display', 'block');
    $('.item_imgs_2nd_row').css('display', 'block');
    $('.item_imgs').find('.up-image__group__dropbox').remove();
    $('.item_imgs_2nd_row').prepend(nextInput(image_num+1));
  }
  if (image_num == 10) {
    $('.item_imgs_2nd_row').css('display', 'none');
  }
  if ($('#size_box option:selected').val() != "") {
    $('#size_box').css('display', 'block');
  }
  if ($('#postage_type_box option:selected').val() != "") {
    $('#postage_type_box').css('display', 'block');
  }
  if ($('.size_box option:selected').val() =="65") {
    $('#size_box').css('display', 'none');
  }
  //販売価格表示
  let input_price = $('.item_input__body__price_box').val();
  let profit = Math.round(input_price * 0.9);
  let charge = (input_price - profit);
  if (300 <= input_price && input_price <= 9999999 ){
    $('.charge_result').html(charge);
    $('.charge_result').prepend('¥');
    $('.profit_result').html(profit);
    $('.profit_result').prepend('¥');
  } else {
    $('.charge_result').html('ー');
    $('.profit_result').html('ー');
  }
  //商品説明ボックスの文字カウント表示
  let count = $('.item_input__body__text_area').text().length;
  $('.countup').text(count);
};
  //---------------------カテゴリーボックスのオプション-------------------//
  function appendOption(category) {
    let html = 
     `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  function appendChildrenBox(insertHTML) {
      let childSelectHtml = '';
      childSelectHtml = `
          <select class="item_input__body__category__children--select" id="children_category">
            <option value="" data-category="" >選択してください</option>
            ${insertHTML}</select>
          <i class = "fa fa-chevron-down"></i>`;
      $('#children_box').append(childSelectHtml);
  }
  function appendGrandchildrenBox(insertHTML) {
      let grandchildSelectHtml = '';
      grandchildSelectHtml = `
          <select class="item_input__body__category__grandchildren--select" id="grandchildren_category" name="item[category_id]">
            <option value="" data-category="" >選択してください</option>
            ${insertHTML}</select>
          <i class = "fa fa-chevron-down"></i>`;
      $('#grandchildren_box').append(grandchildSelectHtml);
  }
  $(document).on("change","#parent_category", function() {
    let parentCategory =  $("#parent_category").val();
    if (parentCategory != "") {
      $.ajax( {
        type: 'GET',
        url: 'get_category_children',
        data: { parent_name: parentCategory },
        dataType: 'json'
      })
      .done(function(children) {
        $("#children_box").empty();
        $("#grandchildren_box").empty();
        $('.size_box').val('');
        $('#size_box').css('display', 'none');
        let insertHTML = '';
        children.forEach(function(child) {
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function() {
        alert('error：子カテゴリーの取得に失敗');
      })
    }else{
      $("#children_box").empty();
      $("#grandchildren_box").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
  $(document).on('change', '#children_box', function() {
    let childId = $('#children_category').val();
    if (childId != ""){
      $.ajax({
        url: 'get_category_grandchildren',
        type: 'GET',
        data: { child_id: childId },
        datatype: 'json'
      })
      .done(function(grandchildren) {
        if (grandchildren.length != 0) {
          $("#grandchildren_box").empty();
          $('.size_box').val('');
          $('#size_box').css('display', 'none');
          let insertHTML = '';
          grandchildren.forEach(function(grandchild) {
            insertHTML += appendOption(grandchild);
          });
          appendGrandchildrenBox(insertHTML);
        }
      })
      .fail(function() {
        alert('error:孫カテゴリーの取得に失敗');
      })
    }else{
      $("#grandchildren_box").empty();
      $('.size_box').val('');
      $('#size_box').css('display', 'none');      
    }
  });
  $(document).on('change', '#grandchildren_box', function() {
    let grandchildId = $('#grandchildren_category').val();
    if (grandchildId != "") {
      $('.size_box').val('');
      $('.size_box option').css('display', 'block');
      $('#size_box').css('display', 'block');
      if (grandchildId <= 66||grandchildId >= 78 && grandchildId <= 80||grandchildId >= 174 && grandchildId <= 176||grandchildId >= 178 && grandchildId <= 181||grandchildId >= 186 && grandchildId <= 194||grandchildId >= 200 && grandchildId <= 247||grandchildId >= 270 && grandchildId <= 274||grandchildId >= 330 && grandchildId <= 332||grandchildId >= 340 && grandchildId <= 342) {
        $('.size_box option[value]').each(function(i) {
          if (i>=11) {
            $('.size_box option[value = ' +(i)+ ']').css('display', 'none');
          }
        });
      }else if (grandchildId >= 67 && grandchildId <= 77||grandchildId >= 248 && grandchildId <= 256) {
        $('.size_box option[value]').each(function(i) {
          if (i>=1&&i<11 || i>=27) {
            $('.size_box option[value = ' +(i)+ ']').css('display', 'none');
          }
        });
      }else if (grandchildId >= 346 && grandchildId <= 376) {
        $('.size_box option[value]').each(function(i) {
          if (i>=1&&i<27 || i>=32) {
            $('.size_box option[value = ' +(i)+ ']').css('display', 'none');
          }
        });
      }else if (grandchildId >= 377 && grandchildId <= 419) {
        $('.size_box option[value]').each(function(i) {
          if (i>=1&&i<32 || i>=39) {
            $('.size_box option[value = ' +(i)+ ']').css('display', 'none');
          }
        });
      }else if (grandchildId >= 420 && grandchildId <= 425) {
        $('.size_box option[value]').each(function(i) {
          if (i>=1&&i<39 || i>=47) {
            $('.size_box option[value = ' +(i)+ ']').css('display', 'none');
          }
        });
      }else{
        $('#size_box').css('display', 'none');
        $('.size_box').val(65);
      }
    } else {
      $('.size_box').val('');
      $('#size_box').css('display', 'none');
    }
  });
  //-------------------------配送料の負担 選択によるイベント発火-------------------------//
  $(document).on('change', '.postage_payer_box', function() {
    if ($('.postage_type_boxoption option:selected').val() !="") {
      $('.postage_type_box').val('');
      $('#postage_type_box').css('display', 'block');
    } else {
      $('.postage_type_box').val('');
      $('#postage_type_box').css('display', 'none');
    }
  })
  //-------------------------販売価格入力によるイベント発火-------------------------//
  $(document).on('input', '.item_input__body__price_box', function() {
    let input_price = $('.item_input__body__price_box').val();
    let profit = Math.round(input_price * 0.9)
    let charge = (input_price - profit)
    if (300 <= input_price && input_price <= 9999999 ){
      $('.charge_result').html(charge)
      $('.charge_result').prepend('¥')
      $('.profit_result').html(profit)
      $('.profit_result').prepend('¥')
    } else {
      $('.charge_result').html('ー');
      $('.profit_result').html('ー');
    }
  });
  //-------------------------商品説明ボックスの文字カウント-------------------------//
$(document).on('keyup', '.item_input__body__text_area', function() {
  $('.item_input__body__text_area').keyup(function() {
    let count = $(this).val().length;
    $('.countup').text(count);
  });
});
  //-----------------------画像のアップロード-----------------------//
  let nextInput = (num, index)=> {
    let html = `<div class="up-image__group__dropbox" data-index="${num}" index="${index}">
                  <input class="item_imgs__default" 
                  type="file" 
                  multiple= "multiple"
                  accept="image/*"></input></div>`;
    return html; 
  }
  let previewImages = (src)=> {   
    let html = `<div class="preview preview_unsave">
                  <div class="img_box">
                    <img src="${src}" class="preview_image"></div>
                  <div class="preview_btn">削除</div></div>`;
    return html;
  }
//-------------------------画像プレビュー表示---------------------//
$(document).on('change','input[type= "file"]', function(e) {
  let reader = new FileReader();
  let file = e.target.files[0];
  reader.readAsDataURL(file);
  reader.onload = function(e) {
    if ($('.preview').length <= 4) {
      $('.previews').append(previewImages(e.target.result));
    } else {
      $('.previews_2nd_row').append(previewImages(e.target.result));
    }
    let preview_count = $('.preview').length;
    let preview_unsave_count = $('.preview_unsave').length;
    let preview_saved_count = $('.hidden-destroy').length;

    if (preview_count <= 5) {
      $('.up-image__group__dropbox').removeClass('up-image__group__dropbox').addClass('image-preview').appendTo('.item_imgs');
    } else {
      $('.up-image__group__dropbox').removeClass('up-image__group__dropbox').addClass('image-preview').appendTo('.item_imgs_2nd_row');
    }
    if (preview_count <= 4) {
      $('.item_imgs').prepend(nextInput(preview_count + 1, preview_unsave_count + 1));
    } else {
      $('.item_imgs_2nd_row').prepend(nextInput(preview_count + 1, preview_unsave_count + 1));
    }

    $('.image_text_message').css('display', 'none');
    $('.img_error_message').css('display', 'none');
    if (preview_count == 5) {
      $('.item_imgs').css('display', 'none');
      $('.under_group').css('display', 'block');
      $('.item_imgs_2nd_row').css('display', 'block');
    }
    if (preview_count == 10) {
      $('.item_imgs_2nd_row').css('display', 'none');
    }

    $('.preview').each(function(i) {
      $(this).attr('data-index', (i+1));
    });
    $('.preview_unsave').each(function(i) {
      $(this).attr('index', (i+1));
    });
    $('.image-preview').each(function(i) {
      $(this).attr('index', (i+1));
      $(this).attr('data-index', (preview_saved_count+i+1));
      $(this).children().attr('name', "item[item_imgs_attributes][" + (preview_saved_count+i) + "][src]");
      $(this).children().attr('data-index', (i+1));
    });
  }
});
//-----------------------削除ボタンをクリック--------------------//
$(document).on("click",'.preview_btn', function() {
  let targetIndex = $(this).parent().data("name");
  $(this).parent().remove();
  if (targetIndex >= 0) {
    let hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    hiddenCheck.prop('checked', true)
  }
  let preview_num = $(this).parent().attr('index');
  let preview_total_num = $(this).parent().attr('data-index');
  let preview_count = $('.preview').length;
  let preview_unsave_count = $('.preview_unsave').length;
  let preview_saved_count = $('.hidden-destroy').length;

  if (preview_num >= 0) {
    $('.image-preview[index ='+preview_num+']').remove();
  }

  $('.preview').each(function(i) {
    $(this).attr('data-index', (i+1));
  });
  $('.preview_unsave').each(function(i) {
    $(this).attr('index', (i+1));
  });
  $('.image-preview').each(function(i) {
    $(this).attr('index', (i+1));
    $(this).attr('data-index', (preview_saved_count+i+1));
    $(this).children().attr('name', "item[item_imgs_attributes][" + (preview_saved_count+i+1) + "][src]");
    $(this).children().attr('data-index', (i+1));
  });
  
  if (preview_count == 4 ) {
    $('.item_imgs_2nd_row').find('.up-image__group__dropbox').remove();
    $('.item_imgs').prepend(nextInput(preview_count + 1, preview_unsave_count + 1));
    $('.item_imgs_2nd_row').css('display', 'none');
    $('.item_imgs').css('display', 'block');
    $('.image_text_message').css('display', 'none');
  } else if (preview_count >=5 && preview_count <=8 && preview_total_num <= 5) {
    $('.preview[data-index ='+5+']').appendTo('.previews');
    $('.image-preview[data-index ='+5+']').appendTo('.item_imgs');
  } else if (preview_count == 9) {
    $('.item_imgs_2nd_row').css('display', 'block');
    if (preview_total_num <= 5) {
      $('.preview[data-index ='+5+']').appendTo('.previews');
      $('.preview[data-index ='+5+']').attr('index', (5));
      $('.image-preview[data-index ='+5+']').appendTo('.item_imgs');
    }
  }
  if (preview_count == 0) {
    $('.image_text_message').css('display', 'block');
    $('.img_error_message').css('display', 'block');
  }
});
  //--------------------------必須項目のエラーメッセージ表示--------------------------//
  $(document).on('click', 'input, select, textarea', function() {
    $('input#item_name').on('blur', function() {    
      if ($('input#item_name').val() == "") {
        $(this).css('border-color', 'red');
        $('.item-name_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.item-name_error_message').css('display', 'none');
      }
    });
    $('.item_input__body__text_area').on('blur', function() {
      if ($('.item_input__body__text_area').val() == "") {
        $(this).css('border-color', 'red');
        $('.item_introduction_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.item_introduction_error_message').css('display', 'none');
      }
    });
    let category_error_message = $('.category_top_error_message')
    $('select#parent_category').on('blur', function() {
      if ($('select#parent_category').val() == '') {
        $(this).css('border-color', 'red');
        category_error_message.css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        category_error_message.css('display', 'none');
      }
    });
    $('#children_box').on('blur','select#children_category', function() {
      if ($('select#children_category').val() == '') {
        $(this).css('border-color', 'red');
        category_error_message.css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        category_error_message.css('display', 'none');
      }
    });
    $('#grandchildren_box').on('blur','select#grandchildren_category', function() {
      if ($('select#grandchildren_category').val() == '') {
        $(this).css('border-color', 'red');
        category_error_message.css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        category_error_message.css('display', 'none');
      }
    });
    $('select.size_box').on('blur', function() {
      if ($('select.size_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.category_size_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.category_size_error_message').css('display', 'none');
      }
    });
    $('select.item_condition_box').on('blur', function() {
      if ($('select.item_condition_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.item_condition_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.item_condition_error_message').css('display', 'none');
      }
    });
    $('select.postage_payer_box').on('blur', function() {
      if ($('select.postage_payer_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.postage_payer_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.postage_payer_error_message').css('display', 'none');
      }
    });
    $('select.postage_type_box').on('blur', function() {
      if ($('select.postage_type_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.postage_type_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.postage_type_error_message').css('display', 'none');
      }
    });
    $('select.prefecture_code_box').on('blur', function() {
      if ($('select.prefecture_code_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.prefecture_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.prefecture_error_message').css('display', 'none');
      }
    });
    $('select.preparation_day_box').on('blur', function() {
      if ($('select.preparation_day_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.preparation_day_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.preparation_day_error_message').css('display', 'none');
      }
    });
    $('input.item_input__body__price_box').on('blur', function() {
      if ($('input.item_input__body__price_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.price_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.price_error_message').css('display', 'none');
      }
    });
    $('label.item_imgs').on('blur', function() {
      if ($('input.item_input__body__price_box').val() == "") {
        $(this).css('border-color', 'red');
        $('.price_error_message').css('display', 'block');
      } else {
        $(this).css('border-color', '#ccc');
        $('.price_error_message').css('display', 'none');
      }
    });
  });
  //-----------------------------出品するボタンクリック時のバリデーション-----------------------------//
  $(document).on('click', '.item_input__body__btn__exhibition_btn', function() {
    if ($('.preview').length){
    } else {
      $('.img_error_message').css('display', 'block');
      alert('出品画像を1枚以上登録してください');
      return false;
    }

    if ($('input#item_name').val() == "") {
      $('input#item_name').focus();
      return false;
    }else if ($('textarea').val() === '') {
      $('textarea').focus();
      return false;
    }else if($('#parent_category').val() === '') {
      $('#parent_category').focus();
      return false;
    }else if($('#children_category').val() === '') {
      $('#children_category').focus();
      return false;
    }else if($('#grandchildren_category').val() === '') {
      $('#grandchildren_category').focus();
      return false;
    }else if($('.size_box').val() === '') {
      $('.size_box').focus();
      return false;
    }else if($('.item_condition_box').val() === '') {
      $('.item_condition_box').focus();
      return false;
    }else if($('.postage_payer_box').val() === '') {
      $('.postage_payer_box').focus();
      return false;
    }else if($('.postage_type_box').val() === '') {
      $('.postage_type_box').focus();
      return false;
    }else if($('.prefecture_code_box').val() === '') {
      $('.prefecture_code_box').focus();
      return false;
    }else if($('.preparation_day_box').val() === '') {
      $('.preparation_day_box').focus();
      return false;
    }else if($('.item_input__body__price_box').val() === '') {
      $('.item_input__body__price_box').focus();
      return false;
    }
  })
