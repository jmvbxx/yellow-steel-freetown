# frozen_string_literal: true

class MissionPlan
  @instance = new

  private_class_method :new

  class << self
    attr_reader :instance
  end

  def print_plan
    plan = <<~PLAN
      Mission plan:
        Travel distance: #{Mission::TRAVEL_DISTANCE_IN_KMS} km
        Payload capacity: #{Mission::PAYLOAD_CAPACITY_IN_KGS} kg
        Fuel capacity: #{Mission::FUEL_CAPACITY_IN_L} liters
        Burn rate: #{Mission::BURN_RATE_IN_L_PER_MIN} liters/min
        Average speed: #{Mission::AVERAGE_SPEED_IN_KMS_PER_HR} km/h
    PLAN
    puts plan
  end
end
