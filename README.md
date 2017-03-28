# README

Rails 5.0.2 with a PostgreSQL database.


This is not the type of README that I would put in a production project, but I figured if you wanted to see my notes, then I should make it easy to find.

## To Run:
- `rake db:create db:migrate`
- `rake export:seed_data > db/seeds.rb`
- `rake db:seed`
- `rails s` and go to localhost:3000

Some FYIs:
- `api/taxonomy/<id>/children` is limited to 25 descendants, `api/taxonomy/<id>/parents` is not limited
- I began to rake db:seed on the ENTIRE data set. I let it run all night but then I decided I just wanted to add a couple of the optional features, so I stopped it and worked on the data that it got through. What I am turning in uses my own abbreviated files that are just a little bit longer than the provided ones.
- Normally, I would write tests, but I am scared that opening data files will crash my text editor. (I know, I should have done it when I was working on the abbreviated data)


Things I learned while completing this project:
- Atom isn't great with large files
- How to create custom rake tasks to write to seeds.rb: seed files can't hold logic, so in order to copy the data from the taxdmp into the database, I had create a rake task that would parse the file and write commands in the seed file.
- How to use the Ancestry gem: when creating the table, you don't have to set a parent_id column but you can still act like it's there. ScientificName has no parent_id column, but I still set it and it gets added to the ancestry. Ancestry goes from highest node downward.


Things I Hmmed and Hawwed over:
- Best way to split a line so that I only had to parse the string once
- Where to store the rank (scientific_name or child_parent):
    - It would be best to store it all together in the scientific_names table. That way, every search only has to query one table. I already have to search for the corresponding entry when I set the ancestry. But this gets tricky because my seeds.rb can't hold logic, so I would have to look into how to pass data from rake task > seed file > model.
    - For simplicity and being consistent with the NCBI, it would be best to store with the other data in the nodes.dmp file.

Bug log:
- parent_id when querying: the parent_id column was not jiving with the parent_id attribute set up by the Ancestry gem. Ancestry does not return in query. Had to rename the column to mother_id.
- CORS
