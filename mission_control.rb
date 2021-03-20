# frozen_string_literal: true

require_relative 'cli'

class MissionControl
  include Cli

  attr_reader :mission_reporter

  attr_accessor :mission

  @retries = 0
  class << self
    attr_accessor :retries
  end

  def initialize(name: nil, mission: Mission.new, mission_reporter: MissionReporter.new(mission))
    @name = name
    @missions = []
    @mission = mission
    @mission_reporter = mission_reporter
    @mission_plan = MissionPlan.instance
  end

  def launch_sequence
    @mission_plan.print_plan
    select_name
    mission.event_sequence
    mission_reporter.print_summary
    play_again?
  end

  # This is part of the requirements but is never used
  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end

  def play_again?
    return mission.abort! unless prompt_user('Would you like to launch again?')

    self.class.retries += 1
    @missions << mission
    total_distance_traveled = @missions.sum(&:distance_traveled)
    total_elapsed_time = @missions.sum(&:elapsed_time)
    puts '********** Testing **********'
    puts "Total distance traveled is #{total_distance_traveled}"
    puts "Total elapsed time is #{total_elapsed_time}"
    puts '*****************************'

    self.mission = Mission.new
    launch_sequence
  end
end
