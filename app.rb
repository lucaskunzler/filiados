require 'rubygems'
require 'zip'
require 'open-uri'
require 'json/ext'

# ESTADOS = [
#             'AC', 'AL', 'AP', 'AM', 'BA',
#             'CE', 'DF', 'ES', 'GO', 'MA',
#             'MT', 'MS', 'MG', 'PA', 'PB',
#             'PR', 'PE', 'PI', 'RJ', 'RN',
#             'RS', 'RO', 'RR', 'SC', 'SP',
#             'SE', 'TO'
#           ]
# PARTIDOS = [
#             'Avante', 'DEM', 'novo', 'pen', 'pc_do_b',
#             'pcb', 'pco', 'pdt', 'phs', 'pmdb',
#             'pmb', 'pmn', 'pp', 'ppl', 'pps',
#             'pr', 'prb', 'pros', 'prp', 'prtb',
#             'psb', 'psc', 'psd', 'psdb', 'psdc',
#             'psl', 'psol', 'psol', 'pt', 'ptb',
#             'ptc', 'pode', 'pv', 'rede', 'sd'
#           ]
ESTADOS = [ 'AC', 'AL' ]
PARTIDOS = [ 'Avante', 'DEM', 'novo', 'pen', 'pc_do_b' ]

zip_urls = []

ESTADOS.each_with_index do |uf, index|
  PARTIDOS.each_with_index do |partido, index|
    puts "Baixando filiados do #{partido} no #{uf}"
    url = "http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_#{partido.downcase}_#{uf.downcase}.zip"
    download = open(url)
    output_dir = "#{uf}/#{partido}"
    Dir.mkdir(output_dir) unless Dir.exist?(output_dir)
    Zip::File.open(download) do |zip_file|
      # Handle entries one by one
      zip_file.each do |entry|
        # Extract to file/directory/symlink
        puts "Extracting #{entry.name}"
        entry.extract("#{File.expand_path(output_dir)}/#{entry.name}")
      end
    end
  end
end
