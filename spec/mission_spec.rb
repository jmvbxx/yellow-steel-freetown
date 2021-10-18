# frozen_string_literal: true

require '../cli'
require '../space_craft'
require '../mission'

RSpec.describe Mission do
  let(:mission) { Mission.new(name: 'Minerva') }

  context '#continue?' do
    it 'returns true' do
      expect(mission.continue?).to be_truthy
    end
  end

  context '#one_in_number' do
    it 'produces a number in the range' do
      expect(mission.one_in_number(1)).to be_truthy
    end
  end

  context "#event_sequence" do
    before(:each) do
      mission.one_in_number(99)
    end

    it "begins the launch sequence" do
      allow($stdin).to receive(:gets).and_return('y')
      expect { mission.event_sequence }.to output(
        "Engage afterburner? (Y/n) Afterburner engaged!\nRelease support structures? (Y/n) Support structures released!\nPerform cross-checks? (Y/n) Cross-checks performed!\n"
      ).to_stdout
    end
  end

  context '#abort!' do
    it 'returns true' do
      expect(mission.abort!).to be_truthy
    end
  end

  context '#fuel_burned' do
    before(:each) do
      @elapsed_time = Mission.elapsed_time
      @elapsed_time = 100
    end

    it 'correctly calculates fuel burned' do
      expect(mission.fuel_burned).to eq(100)
    end
  end
end
