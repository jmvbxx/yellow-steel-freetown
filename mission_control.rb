# frozen_string_literal: true

require_relative 'cli'

class MissionControl
  include Cli

  attr_reader :mission_reporter

  attr_accessor :mission

  @retries = 0
  class << self
    attr_accessor :retries, :total_distance_traveled, :total_elapsed_time
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
    mission_report
    play_again?
  end

  private

  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp # rubocop:disable Lint/UselessAssignment
  end

  def mission_report
    @missions << mission
    self.class.total_distance_traveled = @missions.sum(&:distance_traveled)
    self.class.total_elapsed_time = @missions.sum(&:elapsed_time)
    mission_reporter.print_summary
  end

  def play_again?
    return mission.abort! unless prompt_user('Would you like to launch again?')

    self.class.retries += 1
    self.mission = Mission.new
    launch_sequence
  end
end
