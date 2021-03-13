# frozen_string_literal: true

require_relative 'cli'

class MissionControl
  include Cli

  attr_reader :mission_instance, :mission_reporter

  def initialize(name: nil, mission_instance: Mission.new, mission_reporter: MissionReporter.new(mission_instance))
    @name = name
    @missions = []
    @mission_instance = mission_instance
    @mission_reporter = mission_reporter
    @mission_plan = MissionPlan.instance
    @retries = 0
  end

  def launch_sequence
    @mission_plan.print_plan
    select_name
    mission_instance.event_sequence
    mission_reporter.print_summary
    play_again?
  end

  # This is part of the requirements but is never used
  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end

  def play_again?
    return mission_instance.abort! unless prompt_user('Would you like to launch again?')

    @missions << Mission.new
    if mission_instance.continue?
      launch_sequence
    end
  end
end
