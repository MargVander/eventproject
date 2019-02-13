require 'rails_helper'

RSpec.describe Event, type: :model do

  before(:each) do
    polette = User.new(first_name: "Paulette", last_name: "Jaquemin" , email:"paulette.jaquemin@yolo.com" ,description:"Hello c'est moi polette!", password: "azerty")
    #jacky = User.new(first_name: "jacky", last_name: "Jaquemin" , email:"jacky.jaquemin@yolo.com" ,description:"Hello c'est moi jacky")
    @event = Event.create(description: "azertyuiopqsdfghjklmwxcvbn", location: "Mexico", title: "eventbrite" ,duration: 100 , price: 100 ,start_date: Time.new(2022, 10, 31) , admin: polette)
    @attendee = FactoryBot.create(:user)
    @attendance = Attendance.create(attendee: @attendee, event: @event)
    # event1 =  Event.create(description: "yolo!", location: "Proville", title: "lolilol" ,duration: 100 , price: 100 ,start_date: Time.new(2023, 10, 31) , admin: polette)
    # attendant1 = Attendance.create(attendee:"polette" , event: event1)
  end

  context "validation" do

      it "is valid with valid attributes" do
        expect(@event).to be_a(Event)
        expect(@event).to be_valid
      end

      describe "#location" do
        it "should not be valid without location" do
          bad_event = Event.create(description: "Doye", duration: 500)
          expect(bad_event).not_to be_valid
          expect(bad_event.errors.include?(:location)).to eq(true)
        end

      end

      describe "#title" do
        it "should not be valid without title" do
          bad_event = Event.create(description: "Evenement cool", duration: 500)
          expect(bad_event).not_to be_valid
          expect(bad_event.errors.include?(:title)).to eq(true)
        end

        it "should contain 3 characters at least " do
          expect(@event.title.length >=3).to eq(true)
        end

        it "should contain 140 characters at most " do
          expect(@event.title.length <= 140).to eq(true)
        end
      end

      describe "#description" do
        it "should not be alone in object creation" do
          invalid_event = Event.create(title: "John", location: "Doe", price: 150, duration: 500)
          expect(invalid_event).not_to be_valid
          expect(invalid_event.errors.include?(:description)).to eq(true)
        end

        it "should contain 3 characters at least " do
          expect(@event.description.length >=3).to eq(true)
        end

        it "should contain 1000 characters at most " do
          expect(@event.description.length <= 1000).to eq(true)
        end

      end

      describe "#duration" do
        it "should be a multiple of 5" do
          expect(@event.multiple_of_5?).to eq(true)
        end
      end

      describe "#price" do
        it "should be contained inside [0..1000] " do
          expect(@event.price <= 1000 && @event.price >= 1).to eq(true)
        end
      end


      describe "#start_date" do
        it "should be in the future " do
          expect(@event.start_date.to_date.future?).to eq(true)
        end
      end

    end

    context "type_of" do

      describe ">location" do
        it "should return a string" do
          expect(@event.location).to be_a(String)
        end
      end

      describe ">title" do
        it "should return a string" do
          expect(@event.title).to be_a(String)
        end
      end


      describe ">description" do
        it "should return a string" do
          expect(@event.description).to be_a(String)
        end
      end

      describe ">duration" do
        it "should return a integer" do
          expect(@event.duration).to be_a(Integer)
        end
      end

      describe ">price" do
        it "should return a integer" do
          expect(@event.price).to be_a(Integer)
        end
      end

      describe ">start_date" do
        it "should return a date" do
          expect(@event.start_date).to be_a(Time)
        end
      end

    end

    context "associations" do

      it "should have many attendances" do
        expect(@event.attendances.include?(@attendance)).to eq(true)
      end

      it { expect(@event).to have_many(:attendees) }

    end



end
