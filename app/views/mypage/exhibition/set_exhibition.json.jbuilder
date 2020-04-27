json.array! @exhibitions do |exhibition|
  json.id exhibition.id
  json.name exhibition.name
  json.img exhibition.item_imgs.first.src.url
  json.trading_status exhibition.trading_status
end