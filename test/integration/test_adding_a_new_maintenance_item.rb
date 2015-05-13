require_relative '../test_helper.rb'

### Adding maintenance

#In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

#Usage Example:

#```
  #> ./maintenance_tracker add
  #For which car?
  #1. 2000 Jetta
  #2. 2012 CRV
  #3. 2014 Silverado
  #> 1
  #What job?
  #> Oil Change
  #At what mileage?
  #> 2000000
  #Oil Change for your 2000 Jetta Scheduled at 200000 miles
#```

#Acceptance Criteria

#* User passes in `add` command
#* Program asks for which car, displaying a menu
#* The program asks three questions: "What Job?" and
  #"At what mileage?"
#* The user inputs the appropriate answers
#* That new maintenance is printed out with the mileage it is schudled at


class AddingANewMaintenanceItemTest < Minitest::Test

end
