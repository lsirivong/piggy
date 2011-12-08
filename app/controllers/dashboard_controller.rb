class DashboardController < ApplicationController
  def show
    @envelopes = Envelope.all
  end

end
