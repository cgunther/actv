require 'spec_helper'

describe ACTV::Client do
  before do
    @client = ACTV::Client.new
  end

  describe "#article" do
    context "with a valid article ID passed" do
      before do
        stub_get("/v2/assets/valid_article.json").
        to_return(body: fixture("valid_article.json"), headers: { content_type: "application/json; charset=utf-8" })
      end

      before(:each) do
        @article = @client.article("valid_article")
      end

      it "requests the correct article" do
        a_get("/v2/assets/valid_article.json").should have_been_made
      end

      it "should return the correct summary" do
        @article.summary.should include "Running can be endlessly"
      end

      it "should return the correct description" do
        @article.description.should include "One of the great virtues"
      end

      it "should return the correct by line" do
        @article.by_line.should eq "By Greg Tymon, M.Ed., C.S.C.S."
      end

      it "should return the correct source" do
        @article.source.should include "American Running Association"
      end

      it "should return the correct author photo" do
        @article.author_photo.name.should eq "authorImage"
        @article.author_photo.url.should eq "http://www.active.com/AssetFactory.aspx?did=50534"
        @article.author_photo.caption.should eq "Author"
      end

      it "should return the correct author bio" do
        @article.author_bio.should eq "Author Bio"
      end
    end
  end
end