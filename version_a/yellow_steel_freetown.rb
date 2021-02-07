TRAVEL_DISTANCE = 160       # kilometers
PAYLOAD_CAPACITY = 50_000   # kilgrams including the rocket itself
FUEL_CAPACITY = 1_514_100   # liters of fuel, already included in the payload total
BURN_RATE = 168_233         # liters per minute
AVERAGE_SPEED = 1_500       # kilometers/hr

loop do
  random_seed = rand(1..100)

  puts 'Welcome to yellow-steel-freetown!'
  puts 'Mission plan:'
  puts "  Travel distance:  #{TRAVEL_DISTANCE} km"
  puts "  Payload capacity: #{PAYLOAD_CAPACITY} kg"
  puts "  Fuel capacity:    #{FUEL_CAPACITY} liters"
  puts "  Burn rate:        #{BURN_RATE} liters/min"
  puts "  Average speed:    #{AVERAGE_SPEED} km/h"
  puts "  Random seed:      #{random_seed}"

  print 'What is the name of this mission? '
  mission_name = gets

  print 'Would you like to proceed? (Y/n) '
  proceed = gets.chomp
  break unless proceed.downcase.start_with?('y')

  print 'Engage afterburner? (Y/n) '
  afterburner = gets.chomp
  break unless afterburner.downcase.start_with?('y')
  puts 'Afterburner engaged!'
  break if random_seed % 3 == 0

  print 'Release support structures? (Y/n) '
  release = gets.chomp
  break unless release.downcase.start_with?('y')
  puts 'Support structures released!'
  # break if random_seed % 3 == 0

  print 'Perform cross-checks? (Y/n) '
  cross_checks = gets.chomp
  break unless cross_checks.downcase.start_with?('y')
  puts 'Cross-checks performed!'
  # break if random_seed % 3 == 0

  print 'Launch? (Y/n) '
  launch = gets.chomp
  break unless launch.downcase.start_with?('y')
  puts 'Launched!'

  if random_seed % 5 == 0
    puts 'Your rocket exploded!'
    break
  end

  # loop do
  #   travel_distance = 0
  #   current_speed = rand(1400..1600).to_f
  #   current_distance_traveled = current_speed / 3600 * 30
  #   time_to_destination = TRAVEL_DISTANCE.to_f / AVERAGE_SPEED * 3600
  #
  #   total_distance_traveled = 0
  #
  #   while total_distance_traveled < 160
  #     puts 'Mission status:'
  #     puts "  Current fuel burn rate: #{BURN_RATE} liters/min"
  #     puts "  Current speed: #{current_speed} km/h"
  #     puts "  Elapsed time: 30 seconds"
  #     puts "  Current distance traveled: #{current_distance_traveled} km"
  #     puts "  Time to destination: #{time_to_destination} seconds"
  #     total_distance_traveled += current_distance_traveled
  #   end
  #
  #   break
  # end

end

puts
puts 'Mission aborted!'
