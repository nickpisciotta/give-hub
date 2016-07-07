require 'rails_helper'

RSpec.describe CharitiesController, type: :controller do
  describe "GET #index" do
    it "assigns all charities as @charities and renders the index template" do
      charity = Charity.create(name: "name", description: "description")
      get(:index)

      expect(assigns(:charities)).to eq([charity])
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested charity as @charity and renders the show template" do
      charity = create(:charity)
      get(:show, {:charity_slug => charity.slug.to_param})
      expect(assigns(:charity)).to eq(charity)
      expect(response).to render_template("show")
    end
  end

  # describe "GET #new" do
  #   it "assigns a empty charity as @charity and renders the new template" do
  #
  #     get(:new)
  #     expect(assigns(:charity)).to be_a_new(Artist)
  #     expect(response).to render_template("new")
  #   end
  # end
  #
  # describe "GET #edit" do
  #   it "assigns the requested charity as @charity and renders the edit template" do
  #     charity = create(:charity)
  #     get(:edit, {:id => charity.to_param})
  #     expect(assigns(:charity)).to eq(charity)
  #     expect(response).to render_template("edit")
  #   end
  # end
  #
  #
  # describe "POST #create" do
  #   context "with valid params" do
  #     it "creates a new charity" do
  #       expect {
  #         post :create, {:charity => attributes_for(:charity)}
  #       }.to change(Artist, :count).by(1)
  #     end
  #
  #     it "assigns a newly created charity as @charity" do
  #       post :create, {:charity => attributes_for(:charity)}
  #       expect(assigns(:charity)).to be_a(Artist)
  #       expect(assigns(:charity)).to be_persisted
  #     end
  #
  #     it "redirects to the created charity" do
  #       post :create, {:charity => attributes_for(:charity)}
  #       expect(response).to redirect_to(Artist.last)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns a newly created but unsaved charity as @charity" do
  #       post :create, {:charity => attributes_for(:charity, name: nil)}
  #       expect(assigns(:charity)).to be_a_new(Artist)
  #     end
  #
  #     it "re-renders the 'new' template" do
  #       post :create, {:charity => attributes_for(:charity, name: nil)}
  #       expect(response).to render_template("new")
  #     end
  #   end
  # end
  #
  #
  # describe "PUT #update" do
  #   context "with valid params" do
  #     it "updates an existing charity" do
  #       charity = create(:charity)
  #       put :update, {:id => charity.to_param, :charity => attributes_for(:charity, name: "New name")}
  #       charity.reload
  #       expect(charity.name).to eq("New name")
  #     end
  #
  #     it "assigns requested charity as  charity" do
  #       charity = create(:charity)
  #       put :update, {:id => charity.to_param, :charity => attributes_for(:charity, name: "New name")}
  #       charity.reload
  #       expect(assigns(:charity)).to eq(charity)
  #     end
  #
  #     it "redirects to requested charity show page" do
  #       charity = create(:charity)
  #       put :update, {:id => charity.to_param, :charity => attributes_for(:charity, name: "New name")}
  #       charity.reload
  #       expect(response).to redirect_to(charity)
  #     end
  #   end
  #
  #   context "with invalid params" do
  #     it "assigns requested charity as  charity" do
  #       charity = create(:charity)
  #       put :update, {:id => charity.to_param, :charity => attributes_for(:charity, name: nil)}
  #       charity.reload
  #       expect(assigns(:charity)).to eq(charity)
  #     end
  #
  #     it "renders to edit charity show " do
  #       charity = create(:charity)
  #       put :update, {:id => charity.to_param, :charity => attributes_for(:charity, name: nil)}
  #       charity.reload
  #       expect(response).to render_template(:edit)
  #     end
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   it "destroys the requested charity" do
  #     charity = create(:charity)
  #     expect {
  #       delete :destroy, {:id => charity.to_param}
  #     }.to change(Artist, :count).by(-1)
  #   end
  #
  #   it "redirects to the charities list" do
  #     charity = create(:charity)
  #     delete :destroy, {:id => charity.to_param}
  #     expect(response).to redirect_to(artists_path)
  #   end
  # end

end
