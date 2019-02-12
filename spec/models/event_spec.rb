require 'rails_helper'

RSpec.describe Event, type: :model do

  before(:each) do
		@event = FactoryBot.create(:event)
  end

  it "has a valid factory" do
    expect(build(:event)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@event).to be_a(Event)
    end
    describe "#start_date" do
      it { expect(@event).to validate_presence_of(:start_date) }
      it { is_expected.to allow_value( DateTime.now + 3.day ).for(:start_date) }
      it { is_expected.to_not allow_value( DateTime.now - 3.day ).for(:start_date) }
		end
		describe "#title" do
		  it { expect(@event).to validate_presence_of(:title) }
      it { is_expected.to allow_value("Lorem Ipsum").for(:title) }
      it { is_expected.to_not allow_value("foo").for(:title) }
	  end
    describe "#duration" do
		  it { expect(@event).to validate_presence_of(:duration) }
      it { is_expected.to_not allow_value(4).for(:duration) }
	  end
  end

end
