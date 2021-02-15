class MissionControl
  def initialize(mission_instance)
    @mission_instance = mission_instance
    @launch_sequence = @mission_instance.event_sequence
  end
end
