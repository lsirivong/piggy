class User < ActiveRecord::Base
  has_many :budgets, :dependent => :destroy
  attr_accessible :email, :password, :password_confirmation
  authenticates_with_sorcery!

  validates_length_of :password, :minimum => 3, :message => "password must be at least 3 characters long", :if => :password
  validates_confirmation_of :password, :message => "should match confirmation", :if => :password
  validates :email, :format => {
    :with => /@/, # email addresses can be complicated, do the most trivial thing: make sure there's an '@' in it.
    :message => "should be a valid email address"
    }

  def latest_budget
    budgets.order("end_date DESC").first
  end
end
