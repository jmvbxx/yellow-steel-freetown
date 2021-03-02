class MissionControl
  attr_reader :mission_instance, :mission_plan

  attr_accessor :name

  def initialize(name: nil, mission_instance: nil, mission_plan: MissionPlan.new)
    @name = name
    @mission_instance = mission_instance
    @mission_plan = mission_plan
  end

  def launch_sequence
    mission_plan.print_plan
    select_name
    mission_instance.event_sequence
  end

  def select_name
    print 'What is the name of this mission? '
    name = gets.chomp
  end
end
