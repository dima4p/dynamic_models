class Proxy < ActiveRecord::Base

  HIDE_COLUMNS = %w[id created_at updated_at]

  class << self
    def table_name=(table_name)
      @@table_name = table_name
    end

    def table_name
      @@table_name
    rescue
      'proxies'
    end

    def visible_column_names
      attribute_names - HIDE_COLUMNS
    end

    def visible_columns
      columns.reject do |column|
        HIDE_COLUMNS.include? column.name
      end.inject({}) do |h, column|
        h[column.name.to_sym] = column.type
        h
      end
    end
  end

end
