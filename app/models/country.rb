class Country < ApplicationRecord
  has_one :country_name, dependent: :destroy
  has_many :tlds, dependent: :destroy
  has_many :currencies, dependent: :destroy
  has_one :idd, dependent: :destroy
  has_many :capitals, dependent: :destroy
  has_many :alt_spellings, dependent: :destroy
  has_many :languages, dependent: :destroy
  has_many :translations, dependent: :destroy
  has_many :demonyms, dependent: :destroy
  has_one :country_map, dependent: :destroy
  has_one :car, dependent: :destroy
  has_many :timezones, dependent: :destroy
  has_many :continents, dependent: :destroy
  has_one :country_flag, dependent: :destroy
  has_one :coat_of_arms, dependent: :destroy
  has_one :capital_info, dependent: :destroy


  # Filtra países cujo nome possui exatamente o número de letras informado
  scope :nome_com_tamanho, ->(tamanho) { where("LENGTH(name) = ?", tamanho) }

  # Filtra países pela região (assumindo que a coluna 'region' esteja preenchida)
  scope :por_regiao, ->(regiao) { where(region: regiao) }

  # Filtra países com área maior que o valor informado
  scope :area_maior_que, ->(min_area) { where("area > ?", min_area) }

  # Exemplo de filtro por população (supondo que haja uma coluna 'population')
  scope :populacao_maior_que, ->(min_pop) { where("population > ?", min_pop) }

  # Se você tiver um campo 'continent' ou similar, pode definir:
  scope :por_continente, ->(continents) { where(continents: continents) }

  # Exemplo de filtro por primeira letra do nome (caso queira)
  scope :nome_inicia_com, ->(letra) { where("name LIKE ?", "#{letra}%") }
end
