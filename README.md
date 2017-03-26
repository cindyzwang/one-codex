# README

Rails 5.0.2 with a PostgreSQL database.

Things I learned while completing this project:
- Atom isn't great with large files
- How to create custom rake tasks to write to seeds.rb: seed files can't hold logic, so in order to copy the data from the taxdmp into the database, I had create a rake task that would parse the file and write commands in the seed file.
- How to use the Ancestry gem: when creating the table, you don't have to set a parent_id column but you can still act like it's there. ScientificName has no parent_id column, but I still set it and it gets added to the ancestry. Ancestry goes from highest node downward.
- How to use the rails-api gem: previous versions of rails had the API separation built in

Things I Hmmed and Hawwed over:
- Best way to split a line so that I only had to parse the string once
- Where to store the rank (scientific_name or child_parent):
    - It would be best to store it all together in the scientific_names table. That way, every search only has to query one table. I already have to search for the corresponding entry when I set the ancestry. But this gets tricky because my seeds.rb can't hold logic, so I would have to look into how to pass data from rake task > seed file > model.
    - For simplicity and being consistent with the NCBI, it would be best to store with the other data in the nodes.dmp file.
