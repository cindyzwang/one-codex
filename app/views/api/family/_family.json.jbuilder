json.extract! scientific_name, :taxonomy_id, :name
json.parent scientific_name.mother_id
json.rank scientific_name.rank
