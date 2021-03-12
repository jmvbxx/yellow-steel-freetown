# frozen_string_literal: true

# Consider a helper like this that gets feedback from the user,
# and that does not mutate any state.
module Cli
  def prompt_user(prompt)
    print "#{prompt} (Y/n) "
    gets.chomp.downcase.start_with?('y')
  end
end

class MissionControl
  include Cli

  attr_reader :mission_instance, :mission_plan

  attr_accessor :name

  attr_reader :missions

  def initialize(name: nil, mission_instance: Mission.new)
    @name = name
    @missions = []
    @mission_instance = mission_instance
    @mission_plan = MissionPlan.instance
    @retries = 0
  end

  def launch_sequence
    @mission_plan.print_plan
    select_name
    mission_instance.event_sequence
    play_again?
  end

  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end

  def play_again?
    return mission_instance.abort! unless prompt_user('Would you like to launch again?')

    @missions << Mission.new
    # total_distance = @missions.sum(&:mission_distance)
    launch_sequence
  end
end
