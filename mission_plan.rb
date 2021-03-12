# frozen_string_literal: true

class MissionPlan
  @instance = new

  private_class_method :new

  class << self
    attr_reader :instance
  end

  def print_plan
    puts 'Mission plan:'
    puts "  Travel distance: #{Mission::TRAVEL_DISTANCE_IN_KMS} km"
    puts "  Payload capacity: #{Mission::PAYLOAD_CAPACITY_IN_KGS} kg"
    puts "  Fuel capacity: #{Mission::FUEL_CAPACITY_IN_L} liters"
    puts "  Burn rate: #{Mission::BURN_RATE_IN_L_PER_MINS} liters/min"
    puts "  Average speed: #{Mission::AVERAGE_SPEED_IN_KMS_PER_HR} km/h"
  end
end
