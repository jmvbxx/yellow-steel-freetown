class MissionControl

  def initialize(mission_instance: nil)
    @mission_instance = mission_instance
    @mission_reporter = MissionReporter.new(mission_instance)
  end

  def test
    p @mission_instance.distance_traveled
    p Mission::FUEL_CAPACITY
  end

  def one_in_n(n)
    (1..n).to_a.sample == 1
  end

  def launch_sequence
    while @mission_instance.status != :completed
      if one_in_n(3)
        @mission_instance.tick
        @mission_reporter.print_status
      else
        # @mission.abort! # @mission.explode!
        return unless @mission_instance.continue?
      end
    end

    # @mission_instance.event_sequence
  end
end


class MissionReporter
  def initialize(mission)
    @mission = mission
  end

  def print_status
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{@mission::BURN_RATE} liters/min"
    puts "  Current speed: #{(@mission.current_speed * @mission::SECONDS_PER_HOURS).round(2)} km/h"
    puts "  Elapsed time: #{seconds_to_hms(@mission.elapsed_time)}"
    puts "  Distance traveled: #{@mission.distance_traveled.round(2)} km"
    puts "  Time to destination: #{@mission.time_to_destination.round(2)} seconds"
  end

  def print_summary
    puts "Mission summary:"
    puts "  Total distance traveled: #{distance_traveled.round(2)} km"
    puts "  Number of aborts and retries: #{@aborts}/#{@retries}"
    puts "  Number of explosions: #{@explosions}"
    puts "  Total fuel burned: #{total_fuel_burned.round(0)} liters"
    puts "  Flight time: #{seconds_to_hms(total_time)}"
  end

  private

  def seconds_to_hms(sec)
    "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
  end
end
