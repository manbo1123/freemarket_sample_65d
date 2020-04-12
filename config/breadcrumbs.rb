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

# ログアウト
crumb :mypage_logout do
  link 'ログアウト', logout_mypage_index_path
  parent :mypage
end
#----------------------------------商品関連-------------------------------#
# 商品詳細
crumb :item do |item|
  link "#{item.name}", item_path(item)
  parent :root
end

# 商品検索結果
crumb :search do |query|
  link "#{query}"
  parent :root
end

# カテゴリー一覧
crumb :category do
  link 'カテゴリー一覧', category_index_path
  parent :root
end

# トップカテゴリー
crumb :top_category do |top|
  link "#{top.name}", category_path(top)
  parent :category
end

# ミドルカテゴリー
crumb :middle_category do |middle|
  link "#{middle.name}", category_path(middle)
  parent :top_category, middle.parent
end

# ボトムカテゴリー
crumb :bottom_category do |bottom|
  link "#{bottom.name}", category_path(bottom)
  parent :middle_category, bottom.parent
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