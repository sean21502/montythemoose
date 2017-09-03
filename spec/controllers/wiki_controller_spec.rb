require 'rails_helper'


RSpec.describe WikiController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
 
    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
       
    it "instantiates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end
 
  describe "WIKI create" do
    it "increases the number of Wiki by 1" do
      expect{ post :create, params: { wiki: { title: RandomData.random_title , body: RandomData.random_sentence } } }.to change(Wiki,:count).by(1)
    end
 
    it "assigns the new post to @wiki" do
      post :create, params: { wiki: { title: RandomData.random_title, body: RandomData.random_sentence } }
      expect(assigns(:wiki)).to eq Wiki.last
    end
 
    it "redirects to the new wiki" do
      post :create, params: { wiki: { title: RandomData.random_title , body: RandomData.random_sentence } }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET show" do
    it "returns http success" do
      get :show, params: { id: my_post.id }
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
      get :show, params: { id: my_post.id }
      expect(response).to render_template :show
    end
 
    it "assigns my_post to @wiki" do
      get :show, params: { id: my_post.id }
      expect(assigns(:wiki)).to eq(my_post)
    end
  end

  describe "GET edit" do
    it "returns http success" do
      get :edit, params: { id: my_post.id }
      expect(response).to have_http_status(:success)
    end
 
    it "renders the #edit view" do
      get :edit, params: { id: my_post.id }
      expect(response).to render_template :edit
    end
 
    it "assigns post to be updated to @wiki" do
      get :edit, params: { id: my_post.id }
 
      wiki_instance = assigns(:wiki)
 
      expect(wiki_instance.id).to eq my_post.id
      expect(wiki_instance.title).to eq my_post.title
      expect(wiki_instance.body).to eq my_post.body
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
 
      put :update, params: { id: my_post.id, wiki: {title: new_title, body: new_body } }
 
      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_post.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
    end
 
    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
 
      put :update, params: { id: my_post.id, wiki: {title: new_title, body: new_body } }
      expect(response).to redirect_to my_post
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, params: { id: my_post.id }
      count = Wiki.where({id: my_post.id}).size
      expect(count).to eq 0
    end
 
    it "redirects to posts index" do
      delete :destroy, params: { id: my_post.id }
      expect(response).to redirect_to wiki_path
    end
  end
end
