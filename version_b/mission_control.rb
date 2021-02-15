class MissionControl

  def initialize
    @mission_instance = Mission.new
  end

  def launch_sequence
    @mission_instance.event_sequence
  end
end
