# frozen_string_literal: true

class Mission
  include Cli

  attr_reader :elapsed_time, :distance_traveled

  attr_accessor :mission_reporter

  @aborts = 0
  class << self
    attr_accessor :aborts
  end

  def initialize(name: nil, mission_reporter: MissionReporter.new(self, SpaceCraft.new(self)))
    @name = name
    @mission_reporter = mission_reporter
    @elapsed_time = 0
    @distance_traveled = 0
    @aborted = false
    @space_craft = SpaceCraft.new(self)
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
      launch_step while @space_craft.distance_traveled <= distance_to_explosion
      self.class.explosions += 1
      puts 'Your rocket exploded!'
    else
      launch_step while @distance_traveled <= SpaceCraft::TARGET_DISTANCE_IN_KMS
    end
  end

  def launch_step
    @elapsed_time += 5
    @distance_traveled = @space_craft.current_distance_traveled
    # binding.pry
    mission_reporter.print_status
  end
end
