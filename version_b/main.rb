require_relative 'mission_control'
require_relative 'mission'
require 'pry'

mission_collections = MissionControl.new
mission_collections.launch_sequence
