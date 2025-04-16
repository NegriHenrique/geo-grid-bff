class GridGame
  attr_reader :row_conditions, :column_conditions, :grid

  def initialize(conditions)
    raise ArgumentError, "Devem ser fornecidas exatamente 6 condições" unless conditions.size == 6
    conditions_shuffled = conditions.shuffle
    @row_conditions = conditions_shuffled.slice(0, 3)
    @column_conditions = conditions_shuffled.slice(3, 3)

    attempts = 0
    max_attempts = 200
    begin
      @grid = build_grid
      valid = @grid.all? do |row|
        row.all? { |cell| cell[:possible_answers].any? }
      end
      raise "Grid inválido" unless valid
    rescue
      attempts += 1
      if attempts < max_attempts
        conditions_shuffled = conditions.shuffle
        @row_conditions = conditions_shuffled.slice(0, 3)
        @column_conditions = conditions_shuffled.slice(3, 3)
        retry
      else
        raise "Não foi possível gerar um grid válido após #{max_attempts} tentativas"
      end
    end
  end

  def build_grid
    (0...3).map do |row|
      (0...3).map do |col|
        combine_conditions(row_conditions[row], column_conditions[col])
      end
    end
  end

  def combine_conditions(row_condition, column_condition)
    possible_countries = Country.all
    possible_countries = possible_countries.public_send(row_condition[:scope], row_condition[:arg])
    possible_countries = possible_countries.public_send(column_condition[:scope], column_condition[:arg])
    # Seleciona apenas os atributos desejados (nome e bandeira)
    possible_countries = possible_countries.select(:name, :flag, :id)
    {
      row_condition: row_condition,
      column_condition: column_condition,
      possible_answers: possible_countries.to_a
    }
  end

  def mapping
    {
      row_conditions: row_conditions,
      column_conditions: column_conditions,
      board: grid
    }
  end
end
