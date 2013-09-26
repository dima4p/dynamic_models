class Proxy < ActiveRecord::Base

  HIDE_COLUMNS = %w[id created_at updated_at]

  class << self

    def visible_columns
      columns.reject do |column|
        HIDE_COLUMNS.include? column.name
      end.inject({}) do |h, column|
        h[column.name.to_sym] = column.type
        h
      end
    end

    def visible_column_names
      visible_columns.keys.map(&:to_s)
    end

  end
end
