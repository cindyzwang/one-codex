json.array! @family_members.each do |name|
  json.partial! '/api/family/family', scientific_name: name
end
