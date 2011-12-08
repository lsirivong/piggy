class DashboardController < ApplicationController
  def show
    @untracked_transactions = Transaction.where(:envelope => nil)
    @envelopes = Envelope.all
  end

end
