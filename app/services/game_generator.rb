class GameGenerator
  def self.possible_criterias
    [
      -> {
        num = rand(5..10)
        { scope: :nome_com_tamanho, arg: num, descricao: "Nome com #{num} letras" }
      },
      -> {
        regiao = [ "Africa", "Americas", "Asia", "Europe", "Oceania", "Antarctic" ].sample
        { scope: :por_regiao, arg: regiao, descricao: "Região: #{regiao}" }
      },
      -> {
        area_threshold = [ 100_000, 500_000, 700_000, 1_000_000 ].sample
        { scope: :area_maior_que, arg: area_threshold, descricao: "Área > #{area_threshold} km²" }
      },
      -> {
        pop_threshold = [ 1_000_000, 5_000_000, 10_000_000, 50_000_000 ].sample
        { scope: :populacao_maior_que, arg: pop_threshold, descricao: "População > #{pop_threshold}" }
      },
      -> {
        letra = ("A".."Z").to_a.sample
        { scope: :nome_inicia_com, arg: letra, descricao: "Nome inicia com #{letra}" }
      },
      -> {
        continente = [ "Africa", "Americas", "Asia", "Europe", "Oceania", "Antarctic" ].sample
        { scope: :por_continente, arg: continente, descricao: "Continente: #{continente}" }
      },
      -> {
        timezone = Country.joins(:timezones).distinct.pluck("timezones.value").sample
        { scope: :por_timezone, arg: timezone, descricao: "Timezone: #{timezone}" }
      },
      -> {
        idioma = Country.joins(:languages).distinct.pluck("languages.name").sample
        { scope: :por_idioma, arg: idioma, descricao: "Idioma: #{idioma}" }
      },
      -> {
        moeda = Country.joins(:currencies).distinct.pluck("currencies.code").sample
        { scope: :por_moeda, arg: moeda, descricao: "Moeda: #{moeda}" }
      },
      -> {
        tld = Country.joins(:tlds).distinct.pluck("tlds.value").sample
        { scope: :por_tld, arg: tld, descricao: "TLD: #{tld}" }
      },
      -> {
        traducao = Country.joins(:translations).distinct.pluck("translations.language_code").sample
        { scope: :por_traducao, arg: traducao, descricao: "Tradução: #{traducao}" }
      },
      -> {
        demonym = Country.joins(:demonyms).distinct.pluck("demonyms.female").sample
        { scope: :por_demonym, arg: demonym, descricao: "Demonym female: #{demonym}" }
      },
      -> {
        demonym = Country.joins(:demonyms).distinct.pluck("demonyms.male").sample
        { scope: :por_demonym, arg: demonym, descricao: "Demonym male: #{demonym}" }
      }
    ]
  end

  def self.valid_condition?(condition)
    return false if condition[:arg].nil?
    count = Country.public_send(condition[:scope], condition[:arg]).count rescue 0
    count > 0
  end

  def self.fetch_valid_condition(max_attempts = 10)
    attempts = 0
    loop do
      candidate = possible_criterias.sample.call
      if valid_condition?(candidate)
        candidate[:possible_answers_count] = Country.public_send(candidate[:scope], candidate[:arg]).count rescue 0
        return candidate
      end
      attempts += 1
      break if attempts >= max_attempts
    end
    nil
  end

  def self.generate_conditions(n = 6)
    valid_conditions = []
    attempts = 0
    while valid_conditions.size < n && attempts < n * 10
      condition = fetch_valid_condition
      puts "Tentativa #{attempts + 1}: #{condition}"
      if condition && !valid_conditions.any? { |cond| cond[:scope] == condition[:scope] && cond[:arg] == condition[:arg] }
        valid_conditions << condition
      end
      attempts += 1
    end
    valid_conditions
  end
end
