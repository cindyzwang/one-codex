json.array! @scientific_names do |name|
  json.id name.id
  json.name name.name
  json.parent name.parent_id
  json.rank name.rank
end
