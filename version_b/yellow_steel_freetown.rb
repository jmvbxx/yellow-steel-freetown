class Mission
  TRAVEL_DISTANCE = 160       # kilometers
  PAYLOAD_CAPACITY = 50_000   # kilograms including the rocket itself
  FUEL_CAPACITY = 1_514_100   # liters of fuel, already included in the payload total
  BURN_RATE = 168_233         # liters per minute
  AVERAGE_SPEED = 1_500       # kilometers/hr
  SECONDS_PER_HOURS = 3_600

  attr_reader :elapsed_time, :distance_traveled

  def initialize(name)
    @name = name
    @elapsed_time = 0
    @distance_traveled = 0
    @aborted = false
  end

  def aborted?
    @aborted
  end

  def continue?
    !aborted?
  end

  def prompt_user(prompt)
    print "#{prompt} (Y/n) "
    @aborted = true unless gets.chomp.downcase.start_with?('y')
  end

  def prelaunch_sequence
    engage_afterburner
    release_support_structures
    perform_cross_checks
    launch
  end

  def engage_afterburner
    return unless continue? && prompt_user('Engage afterburner?')
    puts 'Afterburner engaged!'
    if random_seed % 3 == 0
      puts 'Mission aborted!'
    end
  end

  def current_speed
    rand(1400..1600).to_f
  end

  def time_to_destination
    (TRAVEL_DISTANCE.to_f / AVERAGE_SPEED * SECONDS_PER_HOURS) - elapsed_time
  end

  def print_status
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{BURN_RATE} liters/min"
    puts "  Current speed: #{current_speed} km/h"
    puts "  Elapsed time: #{elapsed_time} seconds"
    puts "  Current distance traveled: #{distance_traveled.round(2)} km"
    puts "  Time to destination: #{time_to_destination.round(2)} seconds"
  end
end
