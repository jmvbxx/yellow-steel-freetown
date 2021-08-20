# frozen_string_literal: true

class MissionReporter

  def initialize(mission, mission_control)
    @mission = mission
    @mission_control = mission_control
  end

  def print_status
    status = <<~STATUS
      Mission status:
        Current fuel burn rate: #{SpaceCraft::BURN_RATE_IN_L_PER_MIN} liters/min
        Current speed: #{(@mission.space_craft.current_speed * SpaceCraft::SECONDS_PER_HOURS).round(2)} km/h
        Elapsed time: #{seconds_to_hms(@mission.elapsed_time)}
        Distance traveled: #{@mission.distance_traveled.round(2)} km
        Time to destination: #{@mission_control.time_to_destination.round(2)} seconds
    STATUS
    puts status
  end

  def print_summary
    summary = <<~SUMMARY
      Mission summary:
        Total distance traveled: #{@mission_control.total_distance_traveled.round(2)} km
        Number of aborts and retries: #{@mission_control.mission.aborts}/#{MissionControl.retries}
        Number of explosions: #{MissionControl.explosions}
        Total fuel burned: #{@mission_control.total_fuel_burned.round(0)} liters
        Total flight time: #{seconds_to_hms(@mission_control.total_elapsed_time)}
    SUMMARY

    # fix line 27
    # investigate class instance vs method instance

    puts summary
  end

  private

  def seconds_to_hms(sec)
    format('%02d:%02d:%02d', sec / 3600, sec / 60 % 60, sec % 60) # rubocop:disable Style/FormatStringToken
  end
end


