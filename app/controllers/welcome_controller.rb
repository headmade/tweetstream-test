class WelcomeController < ApplicationController
  def index
    @topics = Topic.limit(10)
    @tweets = Tweet.all
  end
end
