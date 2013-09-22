class ProxiesController < ApplicationController
  before_action :set_table
  before_action :set_proxy, only: [:show, :edit, :update, :destroy]

  # GET /proxies
  # GET /proxies.json
  def index
    @proxies = Proxy.order(:id)
    logger.debug "ProxiesController@#{__LINE__}#index #{@proxies.count}" if logger.debug?
  end

  # GET /proxies/1
  # GET /proxies/1.json
  def show
  end

  # GET /proxies/new
  def new
    @proxy = Proxy.new
  end

  # GET /proxies/1/edit
  def edit
  end

  # POST /proxies
  # POST /proxies.json
  def create
    @proxy = Proxy.new(proxy_params)

    respond_to do |format|
      if @proxy.save
        format.html { redirect_to proxy_url(@proxy, table_name: @table_name),
                      notice: t('proxies.was_created', name: @table_name.classify) }
        format.json { render action: 'show', status: :created, location: @proxy }
      else
        format.html { render action: 'new' }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /proxies/1
  # PATCH/PUT /proxies/1.json
  def update
    respond_to do |format|
      if @proxy.update(proxy_params)
        format.html { redirect_to proxy_url(@proxy, table_name: @table_name),
                      notice: t('proxies.was_updated', name: @table_name.classify) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @proxy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /proxies/1
  # DELETE /proxies/1.json
  def destroy
    @proxy.destroy
    respond_to do |format|
      format.html { redirect_to proxies_url,
                    notice: t('proxies.was_deleted', name: @table_name.classify) }
      format.json { head :no_content }
      format.js
    end
  end

  # POST /proxies/update_column
  # POST /proxies/update_column.js
  def update_column
    Proxy.transaction do
      if params[:force].present?
        changed = []
      else
        changed = Proxy.where('updated_at > ?', params[:taken]).pluck(:id)
        logger.debug "ProxiesController@#{__LINE__}#update_column #{changed.inspect}" if logger.debug?
      end
      if changed.empty?
        attribute = params[:attribute]
        values = params[attribute] || {}
        Proxy.where(id: values.keys).find_each do |proxy|
          value = values[proxy.id.to_s]
          proxy.update_attribute(attribute, value) if proxy.send(attribute) != value
        end
      end
      respond_to do |format|
        format.html { redirect_to proxies_url,
                      notice: t('proxies.were_updated',
                                name: @table_name.classify,
                                attribute: attribute) }
        format.json { head :no_content }
        format.js {render text: changed.to_json}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_proxy
    @proxy = Proxy.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def proxy_params
    params[:proxy].permit!
  end

  def set_table
    @table_name = Proxy.table_name = params[:table_name]
    logger.debug "ProxiesController@#{__LINE__}#set_table #{ActiveRecord::Base.connection.tables.inspect}" if logger.debug?
    raise ActiveRecord::RecordNotFound unless Proxy.connection.tables.include? @table_name
  end
end
