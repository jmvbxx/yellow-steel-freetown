# frozen_string_literal: true

class MissionReporter
  attr_reader :mission

  def initialize(mission)
    @mission = mission
  end

  def print_status
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{Mission::BURN_RATE_IN_L_PER_MIN} liters/min"
    puts "  Current speed: #{(mission.current_speed * Mission::SECONDS_PER_HOURS).round(2)} km/h"
    puts "  Elapsed time: #{seconds_to_hms(mission.elapsed_time)}"
    puts "  Distance traveled: #{mission.distance_traveled.round(2)} km"
    puts "  Time to destination: #{mission.time_to_destination.round(2)} seconds"
  end

  def print_summary
    puts 'Mission summary:'
    puts "  Total distance traveled: #{mission.distance_traveled.round(2)} km"
    puts "  Number of aborts and retries: 0/0"
    puts "  Number of explosions: 0"
    puts "  Total fuel burned: #{mission.total_fuel_burned.round(0)} liters"
    puts "  Flight time: #{seconds_to_hms(mission.total_time)}"
  end

  private

  def seconds_to_hms(sec)
    format('%02d:%02d:%02d', sec / 3600, sec / 60 % 60, sec % 60)
  end
end
