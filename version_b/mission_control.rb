class MissionControl
  attr_reader :mission_instance, :mission_plan, :retries

  attr_accessor :name

  class << self
    attr_reader :retries
  end

  def initialize(name: nil, mission_instance: nil, mission_plan: nil)
    @name = name
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
    return unless mission_instance.continue? && mission_instance.prompt_user('Would you like to launch again?')
    Mission.elapsed_time = Mission.distance_traveled = 0
    @retries += 1
    launch_sequence
  end
end
