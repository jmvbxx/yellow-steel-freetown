class Mission
  TRAVEL_DISTANCE = 160       # kilometers
  PAYLOAD_CAPACITY = 50_000   # kilograms including the rocket itself
  FUEL_CAPACITY = 1_514_100   # liters of fuel, already included in the payload total
  BURN_RATE = 168_233         # liters per minute
  AVERAGE_SPEED = 1_500       # kilometers/hr
  SECONDS_PER_HOURS = 3_600

  @@speeds_arr = []

  attr_reader :elapsed_time, :total_time, :distance_traveled, :aborted, :exploded,
              :mission_plan, :status

  attr_accessor :name

  # This was only included for testing purposes
  # class << self
  #   attr_reader :aborted, :exploded, :distance_traveled
  # end

  def initialize(name: nil, mission_plan: MissionPlan.new)
    @name = name # this does not appear to be used
    @elapsed_time = 0
    @total_time = 0
    @distance_traveled = 0
    @aborted = false
    @exploded = false
    @retries = 0
    @aborts = 0
    @explosions = 0
    @mission_plan = mission_plan
    @status = :pending
  end

  def tick
    event_sequence

    @total_time = @elapsed_time += 5
    @distance_traveled = current_distance_traveled
    print_status
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

  def seconds_to_hms(sec)
    "%02d:%02d:%02d" % [sec / 3600, sec / 60 % 60, sec % 60]
  end

  def one_in_n(n)
    (1..n).to_a.sample == 1
  end

  def event_sequence
    mission_plan.print_plan
    select_name
    engage_afterburner
    release_support_structures
    perform_cross_checks
    launch
    print_summary
    play_again?
  end

  # TODO fix bug where the mission summary prints the number of times that abort happen
  def engage_afterburner
    return unless continue? && prompt_user('Engage afterburner?')
    if one_in_n(3)
      puts 'Mission aborted!'
      @aborts += 1
      play_again?
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
      puts 'Launched!'
      # TODO fix the random distance traveled before explosion
      while (@distance_traveled + rand(max=TRAVEL_DISTANCE)) <= TRAVEL_DISTANCE
        launch_while
      end
      puts 'Your rocket exploded!'
      @explosions += 1
    else
      puts 'Launched!'
      while @distance_traveled <= TRAVEL_DISTANCE
        launch_while
      end
    end
  end

  def play_again?
    return unless continue? && prompt_user('Would you like to launch again?')
    @elapsed_time = @distance_traveled = 0
    @retries += 1
    event_sequence
  end

  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end

  def print_status
    puts 'Mission status:'
    puts "  Current fuel burn rate: #{BURN_RATE} liters/min"
    puts "  Current speed: #{(current_speed * SECONDS_PER_HOURS).round(2)} km/h"
    puts "  Elapsed time: #{seconds_to_hms(elapsed_time)}"
    puts "  Distance traveled: #{distance_traveled.round(2)} km"
    puts "  Time to destination: #{time_to_destination.round(2)} seconds"
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

  def current_speed
    @@speeds_arr << rand(1400..1600).to_f
    average_speed = @@speeds_arr.sum / @@speeds_arr.size
    average_speed / SECONDS_PER_HOURS
  end

  def time_to_destination
    if @distance_traveled < 160
      (TRAVEL_DISTANCE - current_distance_traveled) / current_speed
    else
      0
    end
  end

  def current_distance_traveled
    current_speed * elapsed_time
  end

  def total_fuel_burned
    BURN_RATE * total_time / 60
  end

  def launch_while
    @total_time = @elapsed_time += 5
    @distance_traveled = current_distance_traveled
    print_status
  end
end
