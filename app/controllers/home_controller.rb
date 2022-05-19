class HomeController < ApplicationController
  def index
    @carriers = Carrier.enabled
  end
end