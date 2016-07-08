require 'rails_helper'

RSpec.describe CharitiesController, type: :controller do

  describe "POST #create" do

    context "with invalid params" do
      it "assigns a newly created but unsaved charity as @charity" do
        post :create, {:charity => attributes_for(:charity, name: nil)}
        expect(assigns(:charity)).to be_a_new(Charity)
      end

      it "re-renders the 'new' template" do
        post :create, {:charity => attributes_for(:charity, name: nil)}
        expect(response).to render_template("new")
      end
    end
  end
end
