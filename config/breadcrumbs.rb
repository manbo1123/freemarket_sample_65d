#ルート
crumb :root do
  link "フリマ", root_path
end

#----------------------------------マイページ--------------------------------#
crumb :mypage do
  link "マイページ", mypage_index_path
end

# 会員情報
crumb :mypage_accounts do
  link '会員情報', mypage_accounts_edit_path
  parent :mypage
end

# 発送元・お届け先住所変更
crumb :mypage_sending_destinations do
  link '発送元・お届け先住所変更', mypage_sending_destinations_edit_path
  parent :mypage
end

# クレジットカード情報
crumb :mypage_cards_index do
  link '支払い方法', mypage_cards_index_path
  parent :mypage
end

# クレジットカード情報入力
crumb :mypage_cards_new do
  link 'クレジットカード情報入力', mypage_cards_new_path
  parent :mypage_cards_index
end

# クレジットカード情報登録後の表示
crumb :mypage_cards_show do
  link 'クレジットカード情報', mypage_cards_show_path
  parent :mypage_cards_index
end

# ログアウト
crumb :mypage_logout do
  link 'ログアウト', logout_mypage_index_path
  parent :mypage
end

# いいね一覧
crumb :favorites do
  link 'いいね！一覧', mypage_favorites_index_path
  parent :mypage
end

# 出品した商品一覧(出品中)
crumb :mypage_selling do
  link '出品した商品 - 出品中', mypage_exhibition_selling_path
  parent :mypage
end
# 出品した商品一覧(取引中)
crumb :mypage_dealing do
  link '出品した商品 - 取引中', mypage_exhibition_dealing_path
  parent :mypage
end
# 出品した商品一覧(完売済み)
crumb :mypage_closed do
  link '出品した商品 - 売却済み', mypage_exhibition_closed_path
  parent :mypage
end
# 購入した商品一覧(取引中)
crumb :mypage_purchases_dealing do
  link '購入した商品 - 取引中', mypage_purchases_dealing_path
  parent :mypage
end
# 購入した商品一覧(過去の取引)
crumb :mypage_purchases_closed do
  link '購入した商品 - 過去の取引', mypage_purchases_closed_path
  parent :mypage
end
#----------------------------------商品関連-------------------------------#
#商品関連ページ実装後に作成
  # 商品詳細ページ
  crumb :item do
    link Item.find(params[:id]).name, item_path
    parent :root
  end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).