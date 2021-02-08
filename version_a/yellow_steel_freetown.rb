TRAVEL_DISTANCE = 160       # kilometers
PAYLOAD_CAPACITY = 50_000   # kilgrams including the rocket itself
FUEL_CAPACITY = 1_514_100   # liters of fuel, already included in the payload total
BURN_RATE = 168_233         # liters per minute
AVERAGE_SPEED = 1_500       # kilometers/hr
SECONDS_PER_HOURS = 3_600

loop do
  # random_seed = rand(1..100)
  random_seed = 11

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

  loop do

    mission_time = 0
    total_distance_traveled = 0

    while total_distance_traveled <= TRAVEL_DISTANCE
      mission_time += 30
      current_speed = rand(1400..1600).to_f
      current_distance_traveled = current_speed / SECONDS_PER_HOURS * mission_time
      total_distance_traveled += current_distance_traveled
      time_to_destination = (TRAVEL_DISTANCE.to_f / AVERAGE_SPEED * SECONDS_PER_HOURS) - mission_time

      puts 'Mission status:'
      puts "  Current fuel burn rate: #{BURN_RATE} liters/min"
      puts "  Current speed: #{current_speed} km/h"
      puts "  Elapsed time: #{mission_time} seconds"
      puts "  Current distance traveled: #{total_distance_traveled.round(2)} km"
      puts "  Time to destination: #{time_to_destination.round(2)} seconds"
    end

    break
  end

  print 'Do you wish to continue? (Y/n) '
  continue = gets.chomp
  break unless continue.downcase.start_with?('y')

end

puts
puts 'Mission aborted!'
