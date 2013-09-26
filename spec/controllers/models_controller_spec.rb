require 'spec_helper'

describe ModelsController do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProxiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET 'index'" do
    it "assigns all table_names as @table_names" do
      Proxy.connection.create_table 'schema_migrations'
      get :index, {}, valid_session
      assigns(:table_names).should eq(%w[examples])
      Proxy.connection.drop_table 'schema_migrations' rescue nil
    end
  end

  describe "GET 'show'" do
    it "assigns table_name as @table_name and columns info as @columns" do
      Proxy.should_receive(:visible_columns) {{a: :b}}
      logger.debug "Rspec ModelsController@#{__LINE__}#GET 'show'"
      get 'show', {id: 'examples'}, valid_session
      assigns(:table_name).should == 'examples'
      assigns(:columns).should == {a: :b}
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    before :each do
      Proxy.connection.drop_table 'examples'
    end

    describe "with valid params" do
      before :each do
        @file = fixture_file_upload 'files/examples.yml', 'application/octet-stream'
      end

      it "should create table" do
        post 'create', {file: @file}, valid_session
        Proxy.connection.tables.size.should == 1
      end

      it "should redirect_to models_url" do
        post 'create', {file: @file}, valid_session
        response.should redirect_to(models_url)
      end
    end

    describe "with invalid params" do
      it 're-renders :new template if file is invalid with :not_hash alert' do
        file = fixture_file_upload 'files/examples_bad.yml', 'application/octet-stream'
        post 'create', {file: file}, valid_session
        flash.alert.should == I18n.t('models.create.not_hash')
        response.should render_template("new")
      end

      it 're-renders :new template if file has more than one description with :not_single alert' do
        file = fixture_file_upload 'files/examples_double.yml', 'application/octet-stream'
        logger.debug "Rspec ModelsController@#{__LINE__}#GET 'create'"
        post 'create', {file: file}, valid_session
        flash.alert.should == I18n.t('models.create.not_single')
        response.should render_template("new")
      end

      it 're-renders :new template if it tha table exists already with :exists alert' do
        file = fixture_file_upload 'files/examples.yml', 'application/octet-stream'
        logger.debug "Rspec ModelsController@#{__LINE__}#GET 'create'"
        post 'create', {file: file}, valid_session
        file = fixture_file_upload 'files/examples.yml', 'application/octet-stream'
        post 'create', {file: file}, valid_session
        flash.alert.should == I18n.t('models.create.exists')
        response.should render_template("new")
      end

      it 're-renders :new template if the description has wrong fields with :not_hash alert' do
        file = fixture_file_upload 'files/examples_no_fileds_hash.yml', 'application/octet-stream'
        logger.debug "Rspec ModelsController@#{__LINE__}#GET 'create'"
        post 'create', {file: file}, valid_session
        flash.alert.should == I18n.t('models.create.not_hash')
        response.should render_template("new")
      end

      it 're-renders :new template if the description has no fields with :empty alert' do
        file = fixture_file_upload 'files/examples_no_fileds.yml', 'application/octet-stream'
        logger.debug "Rspec ModelsController@#{__LINE__}#GET 'create'"
        post 'create', {file: file}, valid_session
        flash.alert.should == I18n.t('models.create.empty')
        response.should render_template("new")
      end

      it 're-renders :new template if the description has wrong field typee with :wrong_field alert' do
        file = fixture_file_upload 'files/examples_wrong_field.yml', 'application/octet-stream'
        logger.debug "Rspec ModelsController@#{__LINE__}#GET 'create'"
        post 'create', {file: file}, valid_session
        flash.alert.should == I18n.t('models.create.wrong_field', column_name: 'name', type: 'strin')
        response.should render_template("new")
      end
    end
  end

  describe "DELETE 'destroy'" do
    it "destroys the requested proxy" do
      delete :destroy, {:id => 'examples'}, valid_session
      Proxy.connection.tables.size.should == 0
    end

    it "redirects to the models list" do
      delete :destroy, {:id => 'examples'}, valid_session
      response.should redirect_to(models_url)
    end
  end

end
