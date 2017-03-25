# TODO: optimize line splitting

namespace :export do
  desc "seed database with names and relationships"
  task :seed_data => :environment do
    current_id = "1"
    n_names = []

    # Field terminator is "\t|\t"; Row terminator is "\t|\n"
    File.open(Rails.root.join('lib', 'assets', 'taxdmp', 'abbrev-names.dmp'), 'r').each do |line|
      # I wanted to split on those terminators so because doing a gsub then a split means I parse it 2x
      # but the array ends up with a bunch of empty strings...
      # ...line.include?(arg) has to search through more elements
      line.gsub!("'", %q"\\\'")
      line.gsub!(/[(\t)(\n)]/, '')
      line = line.split('|')
      line_id = line[0]

      if line.include?('scientific name')
        s_name = line[1]
        puts %Q[ScientificName.create(name: '#{s_name}', id: #{line_id})]
      end

      if line_id == current_id
        n_names << line[1] unless line.include?('scientific name')
      else
        n_names.each { |n_name| puts %Q[NickName.create(name: '#{n_name}', scientific_name_id: #{current_id})] }
        current_id = line_id
        current_taxon = []
        n_names = []
      end
    end
    n_names.each { |n_name| puts %Q[NickName.create(name: '#{n_name}', scientific_name_id: #{current_id})] }



    File.open(Rails.root.join('lib', 'assets', 'taxdmp', 'abbrev-nodes.dmp'), 'r').each do |line|
      line = line.gsub(/[(\t)(\n)]/, '').split('|')
      child_id = line[0]
      parent_id = line[1]
      puts "c = ChildParent.create(id: #{child_id}, parent_id: #{parent_id})"
      puts "ScientificName.find_by(taxonomy_id: #{child_id}).parent_id = c.parent_id"
    end
  end
end
