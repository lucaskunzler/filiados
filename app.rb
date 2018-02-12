require 'rubygems'
require 'zip'
require 'open-uri'
require 'json/ext'

STATES = [
            'AC', 'AL', 'AP', 'AM', 'BA',
            'CE', 'DF', 'ES', 'GO', 'MA',
            'MT', 'MS', 'MG', 'PA', 'PB',
            'PR', 'PE', 'PI', 'RJ', 'RN',
            'RS', 'RO', 'RR', 'SC', 'SP',
            'SE', 'TO'
          ]
PARTIES = [
            'Avante', 'DEM', 'novo', 'pen', 'pc_do_b',
            'pcb', 'pco', 'pdt', 'phs', 'pmdb',
            'pmb', 'pmn', 'pp', 'ppl', 'pps',
            'pr', 'prb', 'pros', 'prp', 'prtb',
            'psb', 'psc', 'psd', 'psdb', 'psdc',
            'psl', 'psol', 'psol', 'pt', 'ptb',
            'ptc', 'pode', 'pv', 'rede', 'sd'
          ]
BASE_URI = "http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/"

def download(party, state)
  tail = "filiados_#{party.downcase}_#{state.downcase}.zip"
  IO.copy_stream(open(BASE_URI + tail), "#{tail}")
end

def process(file)
  Zip::File.open(file) do |zip_file|
    zip_file.each do |entry|
      next if entry.name == "aplic/sead/lista_filiados/uf/leiame.pdf"
      content = entry.get_input_stream.read
      puts content
    end
  end
end