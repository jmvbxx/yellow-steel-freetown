# frozen_string_literal: true

class Mission
  include Cli

  TRAVEL_DISTANCE_IN_KMS = 160
  PAYLOAD_CAPACITY_IN_KGS = 50_000
  FUEL_CAPACITY_IN_L = 1_514_100
  BURN_RATE_IN_L_PER_MIN = 168_233
  AVERAGE_SPEED_IN_KMS_PER_HR = 1_500
  SECONDS_PER_HOURS = 3_600
  SECONDS_PER_MINUTE = 60

  attr_reader :elapsed_time, :mission_reporter, :distance_traveled, :total_time

  def initialize(mission_reporter: MissionReporter.new(self))
    @elapsed_time = 0
    @total_time = 0
    @distance_traveled = 0
    @aborted = false
    @exploded = false
    @mission_reporter = mission_reporter
    @speeds_arr = []
  end

  def failed?
    @aborted || @exploded
  end

  def continue?
    !failed?
  end

  def one_in_number(number)
    (1..number).to_a.sample == 1
  end

  def event_sequence
    engage_afterburner
    release_support_structures
    perform_cross_checks
    launch
  end

  # This method is used to calculate an average current speed rather than just
  # a fixed value of 1,500 km/h
  def current_speed
    @speeds_arr << rand(1400..1600).to_f
    average_speed = @speeds_arr.sum / @speeds_arr.size
    average_speed / SECONDS_PER_HOURS
  end

  def time_to_destination
    if @distance_traveled < TRAVEL_DISTANCE_IN_KMS
      (TRAVEL_DISTANCE_IN_KMS - current_distance_traveled) / current_speed
    else
      0
    end
  end

  def total_fuel_burned
    BURN_RATE_IN_L_PER_MIN * total_time / SECONDS_PER_MINUTE
  end

  def abort!
    @aborted = true
  end

  private

  def engage_afterburner
    return abort! unless continue? && prompt_user('Engage afterburner?')

    if one_in_number(3)
      puts 'Mission aborted!'
      event_sequence
    else
      puts 'Afterburner engaged!'
    end
  end

  def release_support_structures
    return abort! unless continue? && prompt_user('Release support structures?')

    puts 'Support structures released!'
  end

  def perform_cross_checks
    return abort! unless continue? && prompt_user('Perform cross-checks?')

    puts 'Cross-checks performed!'
  end

  def launch
    return abort! unless continue? && prompt_user('Launch?')

    puts 'Launched!'
    if one_in_number(5)
      distance_to_explosion = rand(TRAVEL_DISTANCE_IN_KMS)
      launch_step while @distance_traveled <= distance_to_explosion
      puts 'Your rocket exploded!'
    else
      launch_step while @distance_traveled <= TRAVEL_DISTANCE_IN_KMS
    end
  end

  def current_distance_traveled
    current_speed * elapsed_time
  end

  def launch_step
    @total_time = (@elapsed_time += 5)
    @distance_traveled = current_distance_traveled
    mission_reporter.print_status
  end
end
