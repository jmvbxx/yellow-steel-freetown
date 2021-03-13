# frozen_string_literal: true

class Mission
  include Cli

  TRAVEL_DISTANCE_IN_KMS = 160
  PAYLOAD_CAPACITY_IN_KGS = 50_000
  FUEL_CAPACITY_IN_L = 1_514_100
  BURN_RATE_IN_L_PER_MIN = 168_233
  AVERAGE_SPEED_IN_KMS_PER_HR = 1_500
  SECONDS_PER_HOURS = 3_600

  # An individual mission should not be responsible for keeping track of the
  # state of multiple missions over time; anything pertaining to
  # multiple missions should be kept track of within MissionControl;
  # MissionControl might have an array of mission instances, and in order to
  # calculate the total time, total aborts, etc. it might include things
  # like the following:
  # total_time = missions.sum(&:time)
  # total_distance = missions.sum(&:distance)
  # ... where :time, and :distance correspond to public instance methods
  #     on the Mission class.
  # In this way, the responsibilities of Mission can be reduced; it can
  # be restricted to handling a single mission only.
  # MissionControl should have and know of multiple missions. An individual
  # mission should only know about itself.
  attr_reader :total_time, :exploded, :mission_reporter

  attr_accessor :elapsed_time, :distance_traveled

  def initialize(mission_reporter: MissionReporter.new(self))
    @elapsed_time = 0
    @total_time = 0
    @distance_traveled = 0
    @aborted = false
    @exploded = false
    @mission_reporter = mission_reporter
    @speeds_arr = []
  end

  def failed?
    @aborted || exploded
  end

  def continue?
    !failed?
  end

  def one_in_number(number)
    (1..number).to_a.sample == 1
  end

  def event_sequence
    # event_sequence should be in a positition to break
    # out of this process when any one of these steps
    # fails (e.g. returns false). If they return true,
    # you can continue to the next step. Calling `MissionControl.new.play_again?`
    # to accomplish a break in control flow does not make sense; each
    # event in the sequence should be called in such a way that its success
    # or failure allows the next step to proceed without requiring the
    # involvement of an outside class to inform control flow.

    return false unless engage_afterburner
    return false unless release_support_structures
    return false unless perform_cross_checks
    return false unless launch
    mission_reporter.print_summary # remove; handle in `MissionControl`
    @retries += 1
  end

  # TODO: fix bug where the mission summary prints the number of times that abort happen
  def engage_afterburner
    # NEED: abort at any point in the process
    # Change: #prompt_user so that it no longer mutates @aborted state
    # idea:
    return abort! unless continue? && prompt_user('Engage afterburner?')

    if one_in_number(3)
      puts 'Mission aborted!'
      @aborts += 1
      MissionControl.new.play_again?
    else
      puts 'Afterburner engaged!'
    end
  end

  def release_support_structures
    return abort! unless continue? && prompt_user('Release support structures?')

    puts 'Support structures released!'
  end

  def perform_cross_checks
    return abort! unless continue? && prompt_user('Perform cross-checks?')

    puts 'Cross-checks performed!'
  end

  def launch
    return abort! unless continue? && prompt_user('Launch?')

    puts 'Launched!'
    if one_in_number(5)
      # TODO: fix the random distance traveled before explosion
      launch_step while (@distance_traveled + rand(TRAVEL_DISTANCE_IN_KMS)) <= TRAVEL_DISTANCE_IN_KMS
      puts 'Your rocket exploded!'
      @explosions += 1
    else
      launch_step while @distance_traveled <= TRAVEL_DISTANCE_IN_KMS
    end
  end

  # private

  def abort!
    @aborted = true
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

  def current_distance_traveled
    current_speed * elapsed_time
  end

  def total_fuel_burned
    BURN_RATE_IN_L_PER_MIN * total_time / 60
  end

  def launch_step
    @total_time = @elapsed_time += 5
    @distance_traveled = current_distance_traveled
    mission_reporter.print_status
  end
end
