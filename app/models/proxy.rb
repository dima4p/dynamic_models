class Proxy < ActiveRecord::Base

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
      attribute_names - %w[id created_at updated_at]
    end
  end

end
