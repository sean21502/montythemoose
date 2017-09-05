require 'rails_helper'

RSpec.describe Wiki, type: :model do

  let(:name) { RandomData.random_sentence }
  let(:description) { RandomData.random_paragraph }
  let(:title) { RandomData.random_sentence }
  let(:body) { RandomData.random_paragraph }
  let(:user) { create(:user) }
 

  let(:wiki) { Wiki.create!(title: "New Wiki Title", body: "New Wiki Body", private: false, user: user) }
 
  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "New Wiki Title", body: "New Wiki Body")
    end
  end
end
