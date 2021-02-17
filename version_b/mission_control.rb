class MissionControl

  def initialize(mission_instance: nil)
    @mission_instance = mission_instance
  end

  def test
    p @mission_instance.distance_traveled
    p Mission::FUEL_CAPACITY
  end

  def launch_sequence
    @mission_instance.event_sequence
  end
end
