json.array! @favorites do |favorite|
  json.id favorite.id
  json.name favorite.name
  json.img favorite.item_imgs.first.src.url
  json.trading_status favorite.trading_status
end
