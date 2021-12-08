# frozen_string_literal: true

require '../cli'
require '../space_craft'
require '../mission'
require '../mission_control'
require '../mission_reporter'
require '../mission_plan'

RSpec.describe MissionControl do
  let!(:mission) { Mission.new(name: 'Minerva') }
  let!(:mission_control) { MissionControl.new(mission: mission) }

  context 'integration' do
    it 'counts aborts' do
      expect(mission).to receive(:one_in_number).and_return(true)
      expect($stdin).to receive(:gets).and_return('y').exactly(2).times
      expect($stdin).to receive(:gets).and_return('n')

      mission_control.launch_sequence
    end

    it 'completes successfully' do
      expect($stdin).to receive(:gets).and_return('y').exactly(4).times
      expect($stdin).to receive(:gets).and_return('n')

      mission_control.launch_sequence
    end
  end
end
