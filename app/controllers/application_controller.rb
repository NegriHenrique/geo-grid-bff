class ApplicationController < ActionController::API
  def index
    @countries = Country.joins(
      :tlds,
      :currencies,
      :idd,
      :capitals,
      :alt_spellings,
      :languages,
      :demonyms,
    )

    render json: @countries.as_json(
      include: {
        tlds: { only: [:value] },
        currencies: { only: [:code, :name, :symbol] },
        idd: { only: [:root, :suffixes] },
        capitals: { only: [:name] },
        alt_spellings: { only: [:value] },
        languages: { only: [:code, :name] },
        demonyms: { only: [:language_code, :female, :male] },
      },
    )
  end
end
