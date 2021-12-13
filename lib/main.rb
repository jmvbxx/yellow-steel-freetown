# frozen_string_literal: true

require_relative 'mission_reporter'
require_relative 'mission_control'
require_relative 'mission_plan'
require_relative 'mission'
require_relative 'space_craft'

mission_control = MissionControl.new(mission: Mission.new)
puts 'Welcome to yellow-steel-freetown!'
mission_control.launch_sequence
