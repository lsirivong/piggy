class DashboardController < ApplicationController
  def show
    @envelopes = Envelope.all
    @goals = Goal.all
  end

end
