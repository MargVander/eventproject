require 'rails_helper'

RSpec.describe Event, type: :model do

  before(:each) do
		@attendance = FactoryBot.create(:attendance)
  end

  it "has a valid factory" do
    expect(build(:attendance)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@attendance).to be_a(Attendance)
    end
  end


end
