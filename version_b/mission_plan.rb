class MissionPlan
  @instance = new

  private_class_method :new

  def self.instance
    @instance
  end

  def print_plan
    puts "Mission plan:"
    puts "  Travel distance: #{Mission::TRAVEL_DISTANCE} km"
    puts "  Payload capacity: #{Mission::PAYLOAD_CAPACITY} kg"
    puts "  Fuel capacity: #{Mission::FUEL_CAPACITY} liters"
    puts "  Burn rate: #{Mission::BURN_RATE} liters/min"
    puts "  Average speed: #{Mission::AVERAGE_SPEED} km/h"
  end
end
