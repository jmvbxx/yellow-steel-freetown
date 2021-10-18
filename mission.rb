# frozen_string_literal: true

class Mission
  include Cli

  attr_accessor :aborts, :explosions, :space_craft, :elapsed_time, :distance_traveled

  def initialize(name: nil, space_craft: SpaceCraft.new)
    @name = name
    @elapsed_time = 0
    @distance_traveled = 0
    @aborted = false
    @space_craft = space_craft
    @aborts = 0
    @explosions = 0
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

  def fuel_burned(elapsed_time)
    SpaceCraft::BURN_RATE_IN_L_PER_MIN * elapsed_time / SpaceCraft::SECONDS_PER_MINUTE
  end

  private

  def name
    print 'What is the name of this mission? '
    @name = STDIN.gets.chomp
  end

  def rename?
    prompt_user('Do you want to rename your mission?')
  end

  def engage_afterburner
    return abort! unless continue? && prompt_user('Engage afterburner?')

    if one_in_number(3)
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
