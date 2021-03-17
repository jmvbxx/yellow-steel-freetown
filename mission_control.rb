# frozen_string_literal: true

require_relative 'cli'

class MissionControl
  include Cli

  attr_reader :mission, :mission_reporter

  def initialize(name: nil, mission: Mission.new, mission_reporter: MissionReporter.new(mission))
    @name = name
    @missions = []
    @mission = mission
    @mission_reporter = mission_reporter
    @mission_plan = MissionPlan.instance
    @retries = 0
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

    @missions << mission
    total_distance_traveled = @missions.sum(&:distance_traveled)
    total_elapsed_time = @missions.sum(&:elapsed_time)
    puts '********** Testing **********'
    puts "Total distance traveled is #{total_distance_traveled}"
    puts "Total elapsed time is #{total_elapsed_time}"
    puts '*****************************'
    if mission.continue?
      Mission.new
      launch_sequence
    end
  end
end
