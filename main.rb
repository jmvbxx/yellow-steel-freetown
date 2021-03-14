# frozen_string_literal: true

require_relative 'mission_reporter'
require_relative 'mission_control'
require_relative 'mission_plan'
require_relative 'mission'
# require 'pry'

mission_collections = MissionControl.new(mission: Mission.new)
puts 'Welcome to yellow-steel-freetown!'
mission_collections.launch_sequence
