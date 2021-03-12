# frozen_string_literal: true

class MissionControl
  attr_reader :mission, :mission_plan

  attr_accessor :name

  def initialize(name: nil, mission: Mission.new)
    @name = name
    @mission = mission
    @mission_plan = MissionPlan.instance
  end

  def launch_sequence
    @mission_plan.print_plan
    select_name
    mission.event_sequence
    play_again?
  end

  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end

  def play_again?
    return unless mission.prompt_user('Would you like to launch again?')

    mission.elapsed_time = mission.distance_traveled = 0
    launch_sequence
  end
end
