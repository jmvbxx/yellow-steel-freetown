# frozen_string_literal: true

require_relative 'spec_helper'
require '../lib/cli'
require '../lib/space_craft'
require '../lib/mission'
require '../lib/mission_control'
require '../lib/mission_reporter'
require '../lib/mission_plan'

RSpec.describe MissionControl do
  let!(:mission) { Mission.new(name: 'Minerva') }
  let!(:mission_control) { MissionControl.new(mission: mission) }

  describe 'integration' do
    it 'counts aborts across every prompt' do
      expect(mission).to receive(:one_in_number).and_return(true)
      expect($stdin).to receive(:gets).and_return('test-mission', 'y', 'y', 'n', 'n')

      mission_control.launch_sequence
      expect { mission_control.mission_report }.to output(
"Mission summary:\n  Total distance traveled: 0 km\n  Number of aborts and retries: 1/0\n  Number of explosions: 0\n  Total fuel burned: 0 liters\n  Total flight time: 00:00:00\n"
      ).to_stdout
    end

    it 'completes successfully' do
      allow_any_instance_of(Mission).to receive(:one_in_number).and_return(false)
      allow_any_instance_of(SpaceCraft).to receive(:current_speed).and_return(0.416667)
      expect($stdin).to receive(:gets).and_return('test-mission', 'y', 'y', 'y', 'y', 'y', 'y',
                                                  'test-mission', 'y', 'y', 'y', 'y', 'y', 'y',
                                                  'test-mission', 'y', 'y', 'y', 'y', 'y', 'y',
                                                  'test-mission', 'y', 'y', 'y', 'y', 'n', 'y',
                                                  'test-mission', 'y', 'y', 'y', 'n', 'y',
                                                  'test-mission', 'y', 'y', 'n', 'y',
                                                  'test-mission', 'y', 'n', 'y',
                                                  'test-mission', 'n', 'n')

      mission_control.launch_sequence
      expect { mission_control.mission_report }.to output(
"Mission summary:\n  Total distance traveled: 481.25 km\n  Number of aborts and retries: 0/7\n  Number of explosions: 0\n  Total fuel burned: 3238485 liters\n  Total flight time: 00:19:15\n"
      ).to_stdout
    end
  end
end
