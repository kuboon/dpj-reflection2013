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

describe SpeaksController do

  # This should return the minimal set of attributes required to create a valid
  # Speak. As you add validations to Speak, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { FactoryGirl.attributes_for(:speak) }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SpeaksController. Be sure to keep this updated too.
  let(:valid_session) { { user_id: @speak.user_id} }

  before do
    @speak = FactoryGirl.create(:speak)
  end

  describe "GET index" do
    subject(:action){ get :index, {}, valid_session }
    it "assigns all speaks as @speaks" do
      subject
      expect(assigns(:speaks)).to eq([@speak])
    end
  end

  describe "GET show" do
    subject { get :show, {id: @speak.to_param}, valid_session }
    it "assigns the requested speak as @speak" do
      subject
      expect(assigns(:speak)).to eq(@speak)
    end
  end

  describe "GET new" do
    subject(:action){ get :new, {}, valid_session }
    it "assigns a new speak as @speak" do
      subject
      expect(assigns(:speak)).to be_a_new(Speak)
    end
  end

  describe "GET edit" do
    subject(:action){ get :edit, {id: @speak.to_param}, valid_session }
    it "assigns the requested speak as @speak" do
      subject
      expect(assigns(:speak)).to eq(@speak)
    end
  end

  describe "POST create" do
    subject(:action){ post :create, {speak: attributes}, valid_session }
    describe "with valid params" do
      let(:attributes){ valid_attributes }
      it "creates a new Speak" do
        expect{subject}.to change(Speak, :count).by(1)
      end

      it "assigns a newly created speak as @speak" do
        subject
        expect(assigns(:speak)).to be_a(Speak)
        expect(assigns(:speak)).to be_persisted
      end

      it "redirects to the speaks index" do
        expect(subject).to redirect_to(speaks_url)
      end

      context "over the limit" do
        before do
          create_list(:speak, Configurable.speak_limit_counts, user: @speak.user)
        end
        it "re-renders the 'new' template" do
          expect(subject).to render_template("new")
        end
      end

      context "over the limit but time elapsed" do
        before do
          create_list(:speak, Configurable.speak_limit_counts, user: @speak.user, created_at: Configurable.speak_limit_per_minutes.minutes.ago - 1 )
        end
        it "creates a new Speak" do
          expect{subject}.to change(Speak, :count).by(1)
        end
      end
    end

    describe "with invalid params" do
      let(:attributes){ { text: "" } }
      it "assigns a newly created but unsaved speak as @speak" do
        subject
        expect(assigns(:speak)).to be_a_new(Speak)
      end

      it "re-renders the 'new' template" do
        expect(subject).to render_template("new")
      end
    end
  end

  describe "PUT update" do
    subject(:action){ put :update, {id: @speak.to_param, speak: attributes}, valid_session }
    describe "with valid params" do
      let(:attributes){ { "text" => "params" } }
      it "updates the requested speak" do
        subject
        expect(assigns(:speak).text).to eq("params")
      end

      it "assigns the requested speak as @speak" do
        subject
        expect(assigns(:speak)).to eq(@speak)
      end

      it "redirects to the speak" do
        subject
        expect(response).to redirect_to(@speak)
      end
    end

    describe "with invalid params" do
      let(:attributes){ { text: "" } }
      it "assigns the speak as @speak" do
        subject
        expect(assigns(:speak)).to eq(@speak)
        expect(@speak.reload.text).not_to eq("")
      end

      it "re-renders the 'edit' template" do
        expect(subject).to render_template("edit")
      end
    end
  end
end
