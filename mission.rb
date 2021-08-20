# frozen_string_literal: true

class Mission
  include Cli

  attr_accessor :aborts, :space_craft, :elapsed_time, :distance_traveled

  def initialize(name: nil, space_craft: SpaceCraft.new)
    @name = name
    @elapsed_time = 0
    @distance_traveled = 0
    @aborted = false
    @space_craft = space_craft
    @aborts = 0
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
  end

  def abort!
    @aborted = true
  end

  # TODO: This is not calculating properly over multiple missions
  def fuel_burned
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
      @aborts += 1
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
end
