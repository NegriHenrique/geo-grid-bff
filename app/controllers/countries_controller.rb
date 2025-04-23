class CountriesController < ApplicationController
  def index
    @countries = Country.includes(
      :tlds,
      :currencies,
      :idd,
      :capitals,
      :alt_spellings,
      :languages,
      :demonyms,
      :country_map,
      :car,
      :continents,
      :capital_info
    )

    render json: @countries.to_json(
      include: {
        tlds: { only: [ :value ] },
        currencies: { only: [ :code, :name, :symbol ] },
        idd: { only: [ :root, :suffixes ] },
        capitals: { only: [ :name ] },
        alt_spellings: { only: [ :value ] },
        languages: { only: [ :code, :name ] },
        demonyms: { only: [ :language_code, :female, :male ] },
        country_map: { only: [ :google_maps, :open_street_maps ] },
        car: { only: [ :side, :signs ] },
        continents: { only: [ :value ] },
        capital_info: { only: [ :lat, :lng ] }
      }
    )
  end

  def show_ids
     countries = Country.includes(
      :idd,
      :country_name
    ).select(:id, :name)

    render json: countries.to_json({
      include: {
        idd: { only: [ :root, :suffixes ] },
        country_name: { only: [ :name ] }
      }
    })
  end
end
