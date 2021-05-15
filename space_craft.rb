# frozen_string_literal: true

class SpaceCraft
  TRAVEL_DISTANCE_IN_KMS = 160
  PAYLOAD_CAPACITY_IN_KGS = 50_000
  FUEL_CAPACITY_IN_L = 1_514_100
  BURN_RATE_IN_L_PER_MIN = 168_233
  AVERAGE_SPEED_IN_KMS_PER_HR = 1_500
  SECONDS_PER_HOURS = 3_600
  SECONDS_PER_MINUTE = 60

  attr_reader :distance_traveled

  @explosions = 0
  class << self
    attr_accessor :explosions
  end

  def initialize
    @distance_traveled = 0
    @speeds_arr = []
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
    BURN_RATE_IN_L_PER_MIN * elapsed_time / SECONDS_PER_MINUTE
  end
end
