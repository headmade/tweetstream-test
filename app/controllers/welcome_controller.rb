class WelcomeController < ApplicationController
  def index
    @topics = Topic.limit(10)
  end
end
