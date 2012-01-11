class DashboardController < ApplicationController
  def show
    redirect_to Budget.order("created_at DESC").first
  end

end
