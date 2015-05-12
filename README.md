# maintenance_tracker
NSS Cohort 8 Ruby capstone project

## Project Vision

This will be a small command line program that keeps track of completed and upcoming maintenance for the user's vehicles.

Users will be able to add/edit/delete different cars and the maintenance requirements for those cars. The program will give reminders for what's coming up (or what has been missed) based on the current milage of the car. The user can also get a list of completed and upcoming items.

## Features

### Adding a new car

In order to track all the vehicles under my purview I want to be able to add new cars to my database

Usage Example:

```
  > ./maintenance_tracker new car
  Please enter the year of car
  > 2014
  Please enter the make of car
  > Honda
  Please enter the model of car
  > CRV
  2014 Honda CRV added to database
```

Acceptance Criteria

* User passes in `new` command with one argument: car
* Three prompts are printed, asking for year, make, and model of car
* Confirmation is printed showing user's input
* Car is stored in database

### Editing an existing car

In order update a car without having to delete one I want to be able to edit exisiting cars

Usage Example:

```
  >./maintenance_tracker edit
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 2
  What would you like to update?
  1. Name
  2. Year
  3. Make
  4. Model
  > 2
  Please enter the updated year
  > 2001
  The year of your Volkswagon Jetta is now 2001
```

Acceptance Criteria

* User passes in `edit` command and one argument: name of car
* The program asks which car they would like to change, what they would
  and what they would like to update in menu form
* After answering all prompts a confirmation of changes is printed out


### Deleting a car

In order to keep my cars accurate (in case of sale or loss) I want to be able to delete cars

Usage Example:

```
  >./maintenance_tracker delete
  Which car would you like to delete?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 2
  Are you sure you would like to delete your 2012 Honda CRV? (y/n)
  > y
  2012 Honda CRV and all maintanence records deleted from database
```

Acceptance Criteria

* User passes in `delete` command
* List of cars printed out and user asked which car they would like
  deleted
* Program asks for confirmation
* User types `y` or `n` to confirm or deny action
* If confirmed, the car and all records are removed from database
* Confirmation is printed out

### View Milage of Vehicle

In order to check on last updated mileage I want to be able to quickly
view the milage on that car

Usage Example:

```
  >./maintenance_tracker milage
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 2
  Your 2012 Honda CRV has 23000 miles
```

Acceptance Criteria

* User passes in name of car
* List of cars printed out and use asked which one they would like the
  milage for
* The program prints out the year, make, model, and current miles for
  that car


### Update Mileage of Vehicle

In order to quickly store current status of vehicle I want to be able to update the mileage of that vehicle


Usage Example:
```
  > ./maintenance_tracker update
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  What is your current milage?
  > 129000
  2000 Volkswagon Jetta mileage updated to 129000 miles
```

Acceptance Criteria

* User passess `update` command
* List of cars printed out, user asked which car they would like to
  update
* User enters new milage
* New mileage is stored
* A message confirming the storing of that data is printed out

### Get next maintenance

In order to keep track, and be reminded, of the required maintenance for my car I want to be able to input milage and be returned the upcoming maintenance

Usage Example:

```
  > ./maintenance_tracker next
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 2
  The next scheduled maintenance for your Honda CRV is: Oil Change at 130000 miles
```

Acceptance Criteria

* User passes in `next` command
* User enters the number of car they would like the next maintenance for
* Next maintenance is printed out for that car based on current mileage
  in database

### Adding maintenance

In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

Usage Example:

```
  > ./maintenance_tracker add
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  What job?
  > Oil Change
  At what mileage?
  > 2000000
  Oil Change for your 2000 Jetta Scheduled at 200000 miles
```

Acceptance Criteria

* User passes in `add` command
* Program asks for which car, displaying a menu
* The program asks three questions: "What Job?" and
  "At what mileage?"
* The user inputs the appropriate answers
* That new maintenance is printed out with the mileage it is schudled at

### View List of Previous and Upcoming Maintenance

In order to keep track of completed and upcoming maintenance I want to be able to view all maintenance

Usage Example:

```
  > ./maintenance_tracker list
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  1. √ Oil Change at 180000
  2. New Tires at 200000
  3. Fuel Filter at 205000
```

Acceptance Criteria

* User passes in `list` command
* The program asks 'for which car' and lists all available vehicles
* A list of all maintenance is printed out, with a √ next to completed items


### View List of All Maintenance

In order to view a macro picture of the needs of my car I want to be
able to view all previous and upcoming maintenance

Usage Example:

```
  > ./maintenance_tracker list all
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  1. √ Oil Change at 10000
  ...
  7. √ Tire Rotation at 100000
  ...
  10. Timing Belt at 150000
```

Acceptance Criteria
* User passes in `list` command followed by `all` modifier
* Program asks "For which car?" and lists all available cars
* After user input all previous and upcoming maintenance for that car is
  listed

### Deleting Maintenance

In order to remove duplacates and/or unneeded events I want to be able to delete maintenance in database

Usage Example:

```
  > ./maintenance_tracker deleteMaint
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  What would you like to delete?
  1. √ Oil Change at 180000
  2. New Tires at 200000
  3. Fuel Filter at 205000
  > 3
  "Fuel Filter at 205000" deleted for your 2000 Volkswagon Jetta"
```

Acceptance Criteria

* User passes in `deleteMaint` command
* The program asks "for which car" and prints out list of cars
* User enters number of car to edit
* Maintenance list is printed out
* User selects which numbered item they want deleted
* That number is removed from the list
* A confirmation of the removal is printed


### Editing Maintenance Already in Database

In order to mark maintenance as completed or edit typeos I want to be able to list and edit maintenance already in database

Usage Example:

```
  > ./maintenance_tracker editMaint
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  What would you like to edit?
  1. Oil Change at 180000
  2. New Tires at 200000
  3. Fuel Filter at 205000
  > 3
  What would you like to change the name or mileage or mark as complete?
  > Name
  What new name would you like to give it?
  > Cabin Air Filter
  Item for 2000 Volkswagon Jetta now: Cabin Air Filter at 205000

```

Acceptance Criteria

* User passes in `editMaint` command and one argument: Name of car
* Maintenance list is printed out
* User selects which numbered item they want edited
* User is asked if they want to edit the name or the milage for that numbered item
* User types in 'name' or 'mileage'
* Program asks what new name or mileage they want to give it
* User types in the new name or mileage
* A printout confirms the new name and mileage of the item

### Marking Maintenance as Completed

In order to parse maintenance data I want to be able to mark
maintenance as completed

Usage Example:

```
  >./maintenance_tracker editMaint
  For which car?
  1. 2000 Jetta
  2. 2012 CRV
  3. 2014 Silverado
  > 1
  What would you like to edit?
  1. Oil Change at 180000
  2. New Tires at 200000
  3. Fuel Filter at 205000
  > 1
  Would you like to change the name, mileage, or mark as complete?
  > complete
  Oil Change at 180000 for your 2000 Volkswagon Jetta is now marked as
completed
```

Acceptance Criteria

* User passes in `editMaint` command and one argument: Name of car
* Maintenance list is printed out
* User selects which numbered item they want edited
* User is asked if they want to edit the name, milage, or completed status for that numbered item
* User types in `complete`
* A printout confirms the status of that maintenance item
