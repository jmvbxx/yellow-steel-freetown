![Testing](https://github.com/jmvbxx/yellow-steel-freetown/actions/workflows/testing.yaml/badge.svg)

## yellow-steel-freetown

### Launch Instructions

The command to launch this program is `ruby lib/main.rb`

### Testing

From within the `/spec` directory run the command `rspec .` to run the entire test suite.

### Future Improvements

1. Make larger numbers prettier by separating with `,`. For example, `1,000,000` vs `1000000`.
2. I'd like to have a better formula for acceleration. Right now there is instant acceleration to the top speed of approximately 1,500 km/h.
3. I'd like to have a formula to calculate the `current fuel burn rate`. Right now it's a static value.
4. I'd like to reconsider the requirement of asking for the variable `name` as it's never used.
5. Similar to the previous point, the `fuel capacity` information is useless for the purposes of a mission.
6. I'd like to rework the math so that the mission ends at exactly 160.0km compared to right now where the mission ends when the distance travels is greater than or equal to 160. This results in always running the same amount of time but not the exact same distance traveled.
7. It would be great to have a database store the results of each mission instead of just display the results on the screen.
8. Lastly, utilize a framework such as `sinatra` to convert this CLI application into a web application (connecting to the database mentioned earlier).

## Launch Requirements

1. **Use Ruby**. A style guide can be found [here](https://github.com/bbatsov/ruby-style-guide). Use 2 soft-tabs.
1. Use proper object orientation, abstraction and design patterns.
1. Your application should run as a CLI (command line interface). It should flow like a text based game. An in-memory data store is fine. The player should be able to play as many missions as they would like. At the end of each mission, you should output a summary of the mission. At the end of all missions, output the final summary.

## Your Mission

_Your mission, should you choose to accept it, is to launch the rocket into low earth orbit._

### Specifications

#### You will be responsible for conducting the flight into low earth orbit:

    1. Travel Distance: 160 kilometers
    2. Payload capacity: 50,000 kilograms including rocket itself
    3. Fuel capacity: 1,514,100 liters of fuel, already included in the payload total
    4. Burn rate: 168,233 liters per minute
    5. Average speed: 1500 kilometers/hr

#### The rocket launch system is comprised of 4 stages, which must happen in this precise order:

    1. Enable stage 1 afterburner
    2. Disengaging release structure
    3. Cross-checks
    4. Launch

#### Active yellow-steel-freetown:

    1. Manually transition between launch stages in the expected order
    2. yellow-steel-freetown should be able to safely abort launch after stage 1 and retry
    3. One in every 3rd launch will require an abort and retry after stage 1, randomize when it actually happens
    4. One in every 5th launch will explode, randomize when it actually happens

#### Necessary instrumentation information to be provided at the end of each mission:

    1. Total distance traveled (if aborted this would be 0, if exploded, pick a random spot in the timeline).
    2. Total travel time (same as above)

#### Final Summary to be provided at end of all attempted missions:

    1. Total distance traveled (for all missions combined)
    2. Number of abort and retries (for all missions combined)
    3. Number of explosions (for all missions combined)
    4. Total fuel burned (for all missions combined)
    5. Total flight time (for all missions combined)

#### Sample Session:

```
Welcome to yellow-steel-freetown!
Mission plan:
  Travel distance:  160.0 km
  Payload capacity: 50,000 kg
  Fuel capacity:    1,514,100 liters
  Burn rate:        168,240 liters/min
  Average speed:    1,500 km/h
  Random seed:      12
What is the name of this mission? Minerva
Would you like to proceed? (Y/n) Y
Engage afterburner? (Y/n) Y
Afterburner engaged!
Release support structures? (Y/n) Y
Support structures released!
Perform cross-checks? (Y/n) Y
Cross-checks performed!
Launch? (Y/n) Y
Launched!
Mission status:
  Current fuel burn rate: 151,416 liters/min
  Current speed: 1,350 km/h
  Current distance traveled: 12.5 km
  Elapsed time: 0:00:30
  Time to destination: 0:05:54
Mission status:
  Current fuel burn rate: 153,098 liters/min
  Current speed: 1,365 km/h
  Current distance traveled: 24.82 km
  Elapsed time: 0:01:00
  Time to destination: 0:05:27

(...)

Mission status:
  Current fuel burn rate: 164,875 liters/min
  Current speed: 1,470 km/h
  Current distance traveled: 137.34 km
  Elapsed time: 0:05:30
  Time to destination: 0:00:55
Mission status:
  Current fuel burn rate: 154,780 liters/min
  Current speed: 1,380 km/h
  Current distance traveled: 149.93 km
  Elapsed time: 0:06:00
  Time to destination: 0:00:25
Mission summary:
  Total distance traveled: 160.36 km
  Number of abort and retries: 0/0
  Number of explosions: 0
  Total fuel burned: 1,079,091 liters
  Flight time: 0:06:25
Would you like to run another mission? (Y/n) Y
Mission plan:
  Travel distance:  160.0 km
  Payload capacity: 50,000 kg
  Fuel capacity:    1,514,100 liters
  Burn rate:        168,240 liters/min
  Average speed:    1,500 km/h
  Random seed:      12
What is the name of this mission? Minerva II
Would you like to proceed? (Y/n) Y
Engage afterburner? (Y/n) Y
Afterburner engaged!
Release support structures? (Y/n) Y
Support structures released!
Perform cross-checks? (Y/n) Y
Cross-checks performed!
Launch? (Y/n) Y
Mission aborted!
Mission summary:
  Total distance traveled: 160.36 km
  Number of abort and retries: 1/1
  Number of explosions: 0
  Total fuel burned: 1,079,091 liters
  Flight time: 0:06:25
Would you like to run another mission? (Y/n) n
```
