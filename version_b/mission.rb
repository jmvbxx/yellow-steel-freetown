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

  class << self
    attr_reader :aborted, :exploded, :distance_traveled
  end

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

  def one_in_n(n)
    (1..n).to_a.sample == 1
  end

  def event_sequence
    mission_plan.print_plan
    select_name

    engage_afterburner
    release_support_structures
    perform_cross_checks

    print_summary
    play_again?
  end

  def prompt_user(prompt)
    print "#{prompt} (Y/n) "
    @aborted = !gets.chomp.downcase.start_with?('y')
    !@aborted
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

  def current_speed
    @@speeds_arr << rand(1400..1600).to_f
    average_speed = @@speeds_arr.sum / @@speeds_arr.size
    average_speed / SECONDS_PER_HOURS
  end

  private

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
end
