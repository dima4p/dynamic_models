require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProxiesController do

  # This should return the minimal set of attributes required to create a valid
  # Proxy. As you add validations to Proxy, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProxiesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    Proxy.table_name = 'examples'
    Proxy.connection.create_table 'examples'
    Proxy.connection.add_column 'examples', :name, :string
    Proxy.connection.add_column 'examples', :position, :integer
  end

  describe "GET index" do
    it "assigns all proxies as @proxies" do
      proxy = Proxy.create! valid_attributes
      get :index, {table_name: 'examples'}, valid_session
      assigns(:proxies).should eq([proxy])
    end

    it "returns 404 error if invalid table_name is given" do
      proxy = Proxy.create! valid_attributes
      expect {get :index, {table_name: 'inknown'}, valid_session}.to raise_error ActiveRecord::RecordNotFound
    end
  end

  describe "GET show" do
    it "assigns the requested proxy as @proxy" do
      proxy = Proxy.create! valid_attributes
      get :show, {:id => proxy.to_param, table_name: 'examples'}, valid_session
      assigns(:proxy).should eq(proxy)
    end
  end

  describe "GET new" do
    it "assigns a new proxy as @proxy" do
      get :new, {table_name: 'examples'}, valid_session
      assigns(:proxy).should be_a_new(Proxy)
    end
  end

  describe "GET edit" do
    it "assigns the requested proxy as @proxy" do
      proxy = Proxy.create! valid_attributes
      get :edit, {:id => proxy.to_param, table_name: 'examples'}, valid_session
      assigns(:proxy).should eq(proxy)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Proxy" do
        expect {
          post :create, {:proxy => valid_attributes, table_name: 'examples'}, valid_session
        }.to change(Proxy, :count).by(1)
      end

      it "assigns a newly created proxy as @proxy" do
        post :create, {:proxy => valid_attributes, table_name: 'examples'}, valid_session
        assigns(:proxy).should be_a(Proxy)
        assigns(:proxy).should be_persisted
      end

      it "redirects to the created proxy" do
        post :create, {:proxy => valid_attributes, table_name: 'examples'}, valid_session
        response.should redirect_to(proxy_url(Proxy.last, table_name: 'examples'))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved proxy as @proxy" do
        # Trigger the behavior that occurs when invalid params are submitted
        Proxy.any_instance.stub(:save).and_return(false)
        post :create, {:proxy => {  }, table_name: 'examples'}, valid_session
        assigns(:proxy).should be_a_new(Proxy)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Proxy.any_instance.stub(:save).and_return(false)
        post :create, {:proxy => {  }, table_name: 'examples'}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested proxy" do
        proxy = Proxy.create! valid_attributes
        # Assuming there are no other proxies in the database, this
        # specifies that the Proxy created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Proxy.any_instance.should_receive(:update).with({ "these" => "params" })
        put :update, {:id => proxy.to_param, :proxy => { "these" => "params" }, table_name: 'examples'}, valid_session
      end

      it "assigns the requested proxy as @proxy" do
        proxy = Proxy.create! valid_attributes
        put :update, {:id => proxy.to_param, :proxy => valid_attributes, table_name: 'examples'}, valid_session
        assigns(:proxy).should eq(proxy)
      end

      it "redirects to the proxy" do
        proxy = Proxy.create! valid_attributes
        put :update, {:id => proxy.to_param, :proxy => valid_attributes, table_name: 'examples'}, valid_session
        response.should redirect_to(proxy_url(proxy, table_name: 'examples'))
      end
    end

    describe "with invalid params" do
      it "assigns the proxy as @proxy" do
        proxy = Proxy.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Proxy.any_instance.stub(:save).and_return(false)
        put :update, {:id => proxy.to_param, :proxy => {  }, table_name: 'examples'}, valid_session
        assigns(:proxy).should eq(proxy)
      end

      it "re-renders the 'edit' template" do
        proxy = Proxy.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Proxy.any_instance.stub(:save).and_return(false)
        put :update, {:id => proxy.to_param, :proxy => {  }, table_name: 'examples'}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested proxy" do
      proxy = Proxy.create! valid_attributes
      expect {
        delete :destroy, {:id => proxy.to_param, table_name: 'examples'}, valid_session
      }.to change(Proxy, :count).by(-1)
    end

    it "redirects to the proxies list" do
      proxy = Proxy.create! valid_attributes
      delete :destroy, {:id => proxy.to_param, table_name: 'examples'}, valid_session
      response.should redirect_to(proxies_url)
    end
  end

end
