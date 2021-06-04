# frozen_string_literal: true

require_relative 'cli'

class MissionControl
  include Cli

  attr_reader :distance_traveled, :elapsed_time, :total_distance_traveled, :total_elapsed_time

  @retries = 0
  class << self
    attr_accessor :retries
  end

  def initialize(mission: Mission.new, mission_reporter: MissionReporter.new(mission, self))
    @missions = []
    @mission = mission
    @mission_reporter = mission_reporter
    @mission_plan = MissionPlan.instance
    @distance_traveled = 0
    @elapsed_time = 0
    @total_distance_traveled = 0
    @total_elapsed_time = 0
  end

  def launch_sequence
    @mission_plan.print_plan
    @mission.event_sequence
    launch
    mission_report
    play_again?
  end

  def time_to_destination
    if @distance_traveled < SpaceCraft::TARGET_DISTANCE_IN_KMS
      (SpaceCraft::TARGET_DISTANCE_IN_KMS - current_distance_traveled) / @mission.space_craft.current_speed
    else
      0
    end
  end

  private

  def mission_report
    @missions << @mission
    @total_distance_traveled = @missions.sum(&:distance_traveled)
    @total_elapsed_time = @missions.sum(&:elapsed_time)
    @mission_reporter.print_summary
  end

  def play_again?
    return @mission.abort! unless prompt_user('Would you like to launch again?')

    self.class.retries += 1
    @mission = Mission.new
    launch_sequence
  end

  def launch
    return @mission.abort! unless @mission.continue? && prompt_user('Launch?')

    puts 'Launched!'
    if @mission.one_in_number(99)
      distance_to_explosion = rand(SpaceCraft::TARGET_DISTANCE_IN_KMS)
      launch_step while @distance_traveled <= distance_to_explosion
      self.class.explosions += 1
      puts 'Your rocket exploded!'
    else
      launch_step while @distance_traveled <= SpaceCraft::TARGET_DISTANCE_IN_KMS
    end
  end

  def launch_step
    @elapsed_time += 5
    @distance_traveled = current_distance_traveled
    @mission_reporter.print_status
  end

  def current_distance_traveled
    @mission.space_craft.current_speed * @elapsed_time
  end
end
