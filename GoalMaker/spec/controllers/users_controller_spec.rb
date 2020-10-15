require "rails_helper"


RSpec.describe UsersController, type: :controller do 

    describe "GET #new" do 
        it "renders the new user page" do 
            get :new 
            expect(response).to render_template("new")
        end 
    end 

    describe "GET #show" do 
        it "renders the show page of the correct user" do 
            user = create :user 
            get :show, params: { id: user.id }
            expect(response).to render_template("show")
        end 
    end 

    describe "GET #index" do 
        it "renders the index page" do 
            get :index 
            expect(response).to render_template('index')
        end 
    end

    describe "POST #create" do 
        before :each do 
            create :user 
            allow(subject).to receive(:current_user).and_return(User.last)
        end 
        let(:valid_params) { { user: {username: 'Bob', password: 'hello12'} } } 
        let(:invalid_params) {  { user: {username: 'Bob', password: 'hell'} } }
        

        context "with valid params" do 
            it "creates the user" do 
                post :create, params: valid_params
                expect(User.last.username).to eq('Bob')
            end 

            it 'redirects to the user show page' do 
                post :create, params: valid_params 
                expect(response).to redirect_to(user_url(User.last))
            end 
        end 
        context "with invalid params" do 
            it "renders the new user template" do 
                post :create, params: invalid_params 
                expect(response).to render_template('new')
            end 
        end
    end

    describe "GET #edit" do 
        it "render the edit user page" do 
            
        end 
    end






end 