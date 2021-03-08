class Mission
  TRAVEL_DISTANCE = 160       # kilometers
  PAYLOAD_CAPACITY = 50_000   # kilograms including the rocket itself
  FUEL_CAPACITY = 1_514_100   # liters of fuel, already included in the payload total
  BURN_RATE = 168_233         # liters per minute
  AVERAGE_SPEED = 1_500       # kilometers/hr
  SECONDS_PER_HOURS = 3_600

  @@speeds_arr = []

  attr_reader :elapsed_time, :total_time, :distance_traveled, :aborted, :exploded,
              :mission_reporter, :aborts, :explosions

  class << self
    attr_writer :distance_traveled, :elapsed_time
  end

  def initialize(mission_reporter: MissionReporter.new(self), mission_control: MissionControl.new)
    @elapsed_time = 0
    @total_time = 0
    @distance_traveled = 0
    @aborted = false
    @exploded = false
    @aborts = 0
    @explosions = 0
    @mission_reporter = mission_reporter
    @mission_control = mission_control
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
    engage_afterburner
    release_support_structures
    perform_cross_checks
    launch
    mission_reporter.print_summary
  end

  # TODO fix bug where the mission summary prints the number of times that abort happen
  def engage_afterburner
    return unless continue? && prompt_user('Engage afterburner?')
    if one_in_n(3)
      puts 'Mission aborted!'
      @aborts += 1
      @mission_control.play_again?
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
        launch_step
      end
      puts 'Your rocket exploded!'
      @explosions += 1
    else
      puts 'Launched!'
      while @distance_traveled <= TRAVEL_DISTANCE
        launch_step
      end
    end
  end

  # private

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

  def launch_step
    @total_time = @elapsed_time += 5
    @distance_traveled = current_distance_traveled
    mission_reporter.print_status
  end
end
