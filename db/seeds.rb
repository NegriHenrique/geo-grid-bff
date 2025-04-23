# db/seeds.rb
require 'open-uri'
require 'json'

# Mapeamento para tradução dos continentes
CONTINENT_MAPPING = {
  "Americas"   => "Américas",
  "Oceania"    => "Oceania",
  "Europe"     => "Europa",
  "Asia"       => "Ásia",
  "Antarctic"  => "Antártida",
  "Africa"     => "África"
}

url = Rails.root.to_s + "/db/seeds.json"

begin
  countries_json = File.open url
  countries_data = JSON.load countries_json

rescue StandardError => e
  puts "Erro ao buscar dados: #{e.message}"
  exit
end

countries_data.each do |data|
  # Define o nome do país: utiliza a tradução para "por" se existir, senão usa o original
  translated_common = if data["translations"] &&
                           data["translations"]["por"] &&
                           data["translations"]["por"]["common"].to_s.strip != ""
                        data["translations"]["por"]["common"]
  else
                        data["name"]["common"]
  end

  # Cria o registro principal do país com o nome já definido
  country = Country.create!(
    name: translated_common,
    cca2: data["cca2"],
    ccn3: data["ccn3"],
    cca3: data["cca3"],
    independent: data["independent"],
    status: data["status"],
    un_member: data["unMember"],
    region: data["region"],
    landlocked: data["landlocked"],
    area: data["area"],
    population: data["population"],
    start_of_week: data["startOfWeek"],
    flag: data["flags"]["png"],
    lat: data["latlng"] ? data["latlng"][0] : nil,
    lng: data["latlng"] ? data["latlng"][1] : nil
  )

  # TLDs
  if data["tld"]
    data["tld"].each do |tld_value|
      Tld.create!(country: country, value: tld_value)
    end
  end

  # Currencies
  if data["currencies"]
    data["currencies"].each do |code, cur|
      Currency.create!(country: country, code: code, name: cur["name"], symbol: cur["symbol"])
    end
  end

  # Idd
  if data["idd"]
    Idd.create!(
      country: country,
      root: data["idd"]["root"],
      suffixes: data["idd"]["suffixes"]
    )
  end

  # Capitais
  if data["capital"]
    data["capital"].each do |capital_name|
      Capital.create!(country: country, name: capital_name)
    end
  end

  # AltSpellings
  if data["altSpellings"]
    data["altSpellings"].each do |alt|
      AltSpelling.create!(country: country, value: alt)
    end
  end

  # Languages
  if data["languages"]
    data["languages"].each do |code, language_name|
      Language.create!(country: country, code: code, name: language_name)
    end
  end

  # Demonyms (usando "eng")
  if data["demonyms"] && data["demonyms"]["eng"]
    Demonym.create!(
      country: country,
      language_code: "eng",
      female: data["demonyms"]["eng"]["f"],
      male: data["demonyms"]["eng"]["m"]
    )
  end

  # CountryMap
  if data["maps"]
    CountryMap.create!(
      country: country,
      google_maps: data["maps"]["googleMaps"],
      open_street_maps: data["maps"]["openStreetMaps"]
    )
  end

  # Car
  if data["car"]
    Car.create!(
      country: country,
      side: data["car"]["side"],
      signs: data["car"]["signs"]
    )
  end

  # Continents (traduzindo para o português)
  if data["continents"]
    data["continents"].each do |continent|
      translated_continent = CONTINENT_MAPPING[continent] || continent
      Continent.create!(country: country, value: translated_continent)
    end
  end

  # CapitalInfo
  if data["capitalInfo"] && data["capitalInfo"]["latlng"]
    CapitalInfo.create!(
      country: country,
      lat: data["capitalInfo"]["latlng"][0],
      lng: data["capitalInfo"]["latlng"][1]
    )
  end
end

puts "Dados dos países inseridos com sucesso!"
