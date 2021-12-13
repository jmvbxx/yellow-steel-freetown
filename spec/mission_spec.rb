# frozen_string_literal: true

require_relative 'spec_helper'
require '../lib/cli'
require '../lib/space_craft'
require '../lib/mission'

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
    it "begins the launch sequence" do
      allow($stdin).to receive(:gets).and_return('y')
      expect { mission.event_sequence }.to output(
        "Release support structures? (Y/n) Support structures released!\nPerform cross-checks? (Y/n) Cross-checks performed!\n"
      ).to_stdout
    end
  end

  context '#abort!' do
    it 'returns true' do
      expect(mission.abort!).to be_truthy
    end
  end

  context '#fuel_burned' do
    it 'correctly calculates fuel burned' do
      expect(mission.fuel_burned(1)).to eq(2803)
    end
  end
end
