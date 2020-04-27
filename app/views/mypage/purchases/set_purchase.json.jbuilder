json.array! @purchases do |purchase|
  json.id purchase.id
  json.name purchase.name
  json.img purchase.item_imgs.first.src.url
  json.trading_status purchase.trading_status
end
