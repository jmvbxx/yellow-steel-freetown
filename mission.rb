# frozen_string_literal: true

class Mission
  include Cli

  attr_reader :elapsed_time, :distance_traveled

  @aborts = 0
  @explosions = 0
  class << self
    attr_accessor :aborts, :explosions
  end

  def initialize(name: nil, space_craft: SpaceCraft.new)
    @name = name
    @elapsed_time = 0
    @distance_traveled = 0
    @aborted = false
    @space_craft = space_craft
  end

  def continue?
    !@aborted
  end

  def one_in_number(number)
    (1..number).to_a.sample == 1
  end

  def event_sequence
    @name ||= name
    engage_afterburner
    release_support_structures
    perform_cross_checks
    launch
  end

  def abort!
    @aborted = true
  end

  # TODO: This is not calculating properly over multiple missions
  def total_fuel_burned
    SpaceCraft::BURN_RATE_IN_L_PER_MIN * elapsed_time / SpaceCraft::SECONDS_PER_MINUTE
  end

  private

  def name
    print 'What is the name of this mission? '
    @name = gets.chomp
  end

  def rename?
    prompt_user('Do you want to rename your mission?')
  end

  def engage_afterburner
    return abort! unless continue? && prompt_user('Engage afterburner?')

    # TODO: When mission aborts it doesn't 'reset' when another mission is run
    # and the entire `engage_afterburner` method is skipped on the next
    # `event_sequence` run
    if one_in_number(99)
      puts 'Mission aborted!'
      self.class.aborts += 1
      name if rename?
      event_sequence
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
    if one_in_number(99)
      distance_to_explosion = rand(SpaceCraft::TARGET_DISTANCE_IN_KMS)
      launch_step while distance_traveled <= distance_to_explosion
      self.class.explosions += 1
      puts 'Your rocket exploded!'
    else
      launch_step while distance_traveled <= SpaceCraft::TARGET_DISTANCE_IN_KMS
    end
  end

  def launch_step
    @elapsed_time += 5
    @distance_traveled = current_distance_traveled
    # binding.pry
    # mission_reporter.print_status
  end

  def current_distance_traveled
    @space_craft.current_speed * elapsed_time
  end
end
