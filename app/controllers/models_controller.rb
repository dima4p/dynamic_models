class ModelsController < ApplicationController

  before_action :set_table_name, only: [:show, :destroy]

  def index
    @table_names = Proxy.connection.tables.sort -
        %w[schema_migrations]
  end

  def show
    Proxy.table_name = @table_name
    @columns = Proxy.visible_columns
  end

  def new
  end

  def create
    content = YAML.parse(params[:file].read).to_ruby rescue nil
    logger.debug "ModelsController@#{__LINE__}#create #{content.class} #{Hash === content} #{content.inspect}" if logger.debug?
    return parse_error('not_hash') unless Hash === content
    return parse_error('not_single') if content.size > 1
    class_name = I18n.transliterate(content.keys.first, '_').classify
    table_name = class_name.tableize
    return parse_error('exists') if Proxy.connection.tables.include? table_name
    content = content.values.first
    return parse_error('not_hash') unless Hash === content
    return parse_error('empty') if content.size < 1
    Proxy.table_name = table_name
    ActiveRecord::Base.transaction do
      Proxy.connection.create_table table_name
      ok = true
      columns = []
      content.each do |column_name, type|
        begin
          Proxy.connection.add_column table_name, column_name, type
          columns << column_name
        rescue => e
          logger.info "ModelsController@#{__LINE__}#create #{table_name} #{column_name} #{type} #{e.message}"
          flash.alert = t(".wrong_field", column_name: column_name, type: type)
          ok = false
          render 'new'
          raise ActiveRecord::Rollback
        end
      end
      Proxy.connection.add_column table_name, :created_at, :datetime unless columns.include? 'created_at'
      Proxy.connection.add_column table_name, :updated_at, :datetime unless columns.include? 'updated_at'
      redirect_to models_url, notice: t('models.was_created', name: class_name) if ok
    end
#     render text: "#{class_name} #{table_name} #{content.inspect}"
  end

  def destroy
    Proxy.connection.drop_table @table_name
    redirect_to models_url, notice: t('models.was_deleted', name: @table_name.classify)
  end

  private

  def set_table_name
    @table_name = params[:id]
  end

  def parse_error(msg)
    logger.debug "ModelsController@#{__LINE__}#parse_error #{msg} #{params.inspect}" if logger.debug?
    flash.alert = t(".#{msg}")
    render 'new'
  end
end
