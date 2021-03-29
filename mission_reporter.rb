# frozen_string_literal: true

class MissionReporter
  attr_reader :mission

  def initialize(mission)
    @mission = mission
  end

  def print_status
    status = <<~STATUS
      Mission status:
        Current fuel burn rate: #{Mission::BURN_RATE_IN_L_PER_MIN} liters/min
        Current speed: #{(mission.current_speed * Mission::SECONDS_PER_HOURS).round(2)} km/h
        Elapsed time: #{seconds_to_hms(mission.elapsed_time)}
        Distance traveled: #{mission.distance_traveled.round(2)} km
        Time to destination: #{mission.time_to_destination.round(2)} seconds
    STATUS
    puts status
  end

  def print_summary
    summary = <<~SUMMARY
      Mission summary:
        Total distance traveled: #{MissionControl.total_distance_traveled.round(2)} km
        Number of aborts and retries: #{Mission.aborts}/#{MissionControl.retries}
        Number of explosions: #{Mission.explosions}
        Total fuel burned: #{mission.total_fuel_burned.round(0)} liters
        Flight time: #{seconds_to_hms(MissionControl.total_elapsed_time)}
    SUMMARY
    puts summary
  end

  private

  def seconds_to_hms(sec)
    format('%02d:%02d:%02d', sec / 3600, sec / 60 % 60, sec % 60)
  end
end
