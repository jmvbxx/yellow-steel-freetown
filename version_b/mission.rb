class Mission
  TRAVEL_DISTANCE = 160       # kilometers
  PAYLOAD_CAPACITY = 50_000   # kilograms including the rocket itself
  FUEL_CAPACITY = 1_514_100   # liters of fuel, already included in the payload total
  BURN_RATE = 168_233         # liters per minute
  AVERAGE_SPEED = 1_500       # kilometers/hr
  SECONDS_PER_HOURS = 3_600

  attr_reader :elapsed_time, :distance_traveled, :aborted, :exploded
  attr_accessor :name

  def initialize(name)
    @name = name # this does not appear to be used
    @elapsed_time = 0
    @distance_traveled = 0
    @aborted = false
    @exploded = false
  end

  def failed?
    aborted || exploded
  end

  def continue?
    !failed?
  end

  def prompt_user(prompt)
    print "#{prompt} (Y/n) "
    @aborted = !gets.chomp.downcase.start_with?('y')
    !@aborted
  end

  def one_in_n(n)
    (1..n).to_a.sample == 1
  end

  def event_sequence
    print_plan
    select_name
    engage_afterburner
    release_support_structures
    perform_cross_checks
    launch
    play_again?
  end

  def engage_afterburner
    return unless continue? && prompt_user('Engage afterburner?')
    if one_in_n(3)
      puts 'Mission aborted!'
      @aborted = true
    else
      puts 'Afterburner engaged!'
    end
  end

  def release_support_structures
    return unless continue? && prompt_user('Release support structures?')
    puts 'Support structures released!'
  end

  def perform_cross_checks
    return unless continue? && prompt_user('Perform cross-checks?')
    puts 'Cross-checks performed!'
  end

  def launch
    return unless continue? && prompt_user('Launch?')
    if one_in_n(5)
      puts 'Your rocket exploded!'
      @exploded = true
    else
      puts 'Launched!'
      while @distance_traveled <= TRAVEL_DISTANCE
        @elapsed_time += 30
        @distance_traveled = current_distance_traveled
        print_status
      end
    end
  end

  def play_again?
    return unless continue? && prompt_user('Would you like to launch again?')
    @elapsed_time = @distance_traveled = 0
    event_sequence
  end

  def print_plan
    puts "Mission plan:"
    puts "  Travel distance: #{TRAVEL_DISTANCE} km"
    puts "  Payload capacity: #{PAYLOAD_CAPACITY} kg"
    puts "  Fuel capacity: #{FUEL_CAPACITY} liters"
    puts "  Burn rate: #{BURN_RATE} liters/min"
    puts "  Average speed: #{AVERAGE_SPEED} km/h"
  end

  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end

  def print_status
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{BURN_RATE} liters/min"
    puts "  Current speed: #{current_speed} km/h"
    puts "  Elapsed time: #{elapsed_time} seconds"
    puts "  Distance traveled: #{distance_traveled.round(2)} km"
    puts "  Time to destination: #{time_to_destination.round(2)} seconds"
  end

  private

  def current_speed
    rand(1400..1600).to_f
  end

  def time_to_destination
    if @distance_traveled < 160
      (TRAVEL_DISTANCE / current_speed * SECONDS_PER_HOURS) - elapsed_time
    else
      0
    end
  end

  def current_distance_traveled
    current_speed / SECONDS_PER_HOURS * elapsed_time
  end
end
