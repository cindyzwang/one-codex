

def parse_names
  dict = []
  file = "1	|	all	|		|	synonym	|\n
  1	|	root	|		|	scientific name	|\n
  2	|	Bacteria	|	Bacteria <prokaryotes>	|	scientific name	|\n
  2	|	Monera	|	Monera <Bacteria>	|	in-part	|\n
  2	|	Procaryotae	|	Procaryotae <Bacteria>	|	in-part	|\n
  2	|	Prokaryota	|	Prokaryota <Bacteria>	|	in-part	|\n
  2	|	Prokaryotae	|	Prokaryotae <Bacteria>	|	in-part	|\n
  2	|	bacteria	|	bacteria <blast2>	|	blast name	|\n
  2	|	eubacteria	|		|	genbank common name	|\n
  2	|	not Bacteria Haeckel 1894	|		|	synonym	|\n
  2	|	prokaryote	|	prokaryote <Bacteria>	|	in-part	|\n
  2	|	prokaryotes	|	prokaryotes <Bacteria>	|	in-part	|\n
  6	|	Azorhizobium	|		|	scientific name	|\n
  6	|	Azorhizobium Dreyfus et al. 1988 emend. Lang et al. 2013	|		|	authority	|\n
  6	|	Azotirhizobium	|		|	misspelling	|\n
  7	|	ATCC 43989	|		|	type material	|\n
  7	|	Azorhizobium caulinodans	|		|	scientific name	|\n
  7	|	Azorhizobium caulinodans Dreyfus et al. 1988	|		|	authority	|\n
  7	|	Azotirhizobium caulinodans	|		|	equivalent name	|\n
  7	|	CCUG 26647	|		|	type material	|\n
  7	|	DSM 5975	|		|	type material	|\n
  7	|	IFO 14845	|		|	type material	|\n
  7	|	JCM 20966	|		|	type material	|\n
  7	|	LMG 6465	|		|	type material	|\n
  7	|	NBRC 14845	|		|	type material	|\n
  7	|	ORS 571	|		|	type material	|"

  current_id = "1"
  current_taxon = Hash.new([])

  file.split('\n').each do |line|
    line = line.gsub(/\s+/, '')
    row = line.split('|')
    p row
    line_id = row[0]

    if line_id == current_id
      if line.include?('scientific name')
        current_taxon[:scientific_name] = row[1]
      else
        current_taxon[:nick_names] << row[1]
      end
    else
      s_name = current_taxon[:scientific_name]
      n_names = current_taxon[:nick_names]

      # puts "ScientificName.create(name: '#{s_name}')"
      # n_names.each { |n_name| puts "NickName.create(name: '#{n_name}', scientific_name_id: #{current_id})" }
      dict << current_taxon

      current_id = line_id
      current_taxon = Hash.new([])
    end
  end
  p dict
end

parse_names
