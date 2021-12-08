# frozen_string_literal: true

require '../cli'
require '../space_craft'
require '../mission'
require '../mission_control'
require '../mission_reporter'
require '../mission_plan'
require 'pry'

RSpec.describe MissionControl do
  let!(:mission) { Mission.new(name: 'Minerva') }
  let!(:mission_control) { MissionControl.new(mission: mission) }

  context 'integration' do
    it 'counts aborts across every prompt' do
      expect(mission).to receive(:one_in_number).and_return(true)
      expect($stdin).to receive(:gets).and_return('test-mission', 'y', 'y', 'n', 'n')

      mission_control.launch_sequence
      expect { mission_control.mission_report }.to output(
"Mission summary:\n  Total distance traveled: 0 km\n  Number of aborts and retries: 1/0\n  Number of explosions: 0\n  Total fuel burned: 0 liters\n  Total flight time: 00:00:00\n"
      ).to_stdout
    end

    it 'completes successfully' do
      allow(mission).to receive(:one_in_number).and_return(false)
      allow(mission.space_craft).to receive(:current_speed).and_return(0.416667)
      expect($stdin).to receive(:gets).and_return('test-mission', 'y', 'y', 'y', 'y', 'y', 'n')

      mission_control.launch_sequence
      expect { mission_control.mission_report }.to output(
"Mission summary:\n  Total distance traveled: 160.42 km\n  Number of aborts and retries: 0/0\n  Number of explosions: 0\n  Total fuel burned: 1079495 liters\n  Total flight time: 00:06:25\n"
      ).to_stdout
    end
  end
end
