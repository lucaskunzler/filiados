ESTADOS = ['AC', 'AL', 'AP', 'AM', 'BA', 'CE', 'DF', 'ES', 'GO', 'MA', 'MT', 'MS', 'MG', 'PA', 'PB', 'PR', 'PE', 'PI', 'RJ', 'RN', 'RS', 'RO', 'RR', 'SC', 'SP', 'SE', 'TO']
PARTIDOS = ['Avante', 'DEM', 'novo', 'pen', 'pc_do_b', 'pcb', 'pco']

zip_urls = []

ESTADOS.each do |uf|
  PARTIDOS.each do |partido|
    zip_urls << "http://agencia.tse.jus.br/estatistica/sead/eleitorado/filiados/uf/filiados_#{partido.downcase}_#{uf.downcase}.zip"
  end
end

puts zip_urls
puts zip_urls.count