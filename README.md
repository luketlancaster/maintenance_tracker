# maintenance_tracker
NSS Cohort 8 Ruby capstone project

## Project Vision

This will be a small command line program that keeps track of completed and upcoming maintenance for the user's vehicles.

Users will be able to add/edit/delete different cars and the maintenance requirements for those cars. The program will give reminders for what's coming up (or what has been missed) based on the current milage of the car. The user can also get a list of completed and upcoming items.

## Features

### Adding a new car

In order to track all the vehicles under my purview I want to be able to add new cars to my database

Usage Example:

  > `./maintenance_tracker new car`
    Please enter the year of car
  > 2014
    Please enter the make of car
  > Honda
    Please enter the model of car
  > CRV
    2014 Honda CRV added to database

Acceptance Criteria

  * User passes in "new car" argument to program
  * Three prompts are printed, asking for year, make, and model of car
  * Confirmation is printed showing user's input
  * Car is stored in database

### Editing an existing car

In order update a car without having to delete one I want to be able to edit exisiting cars

### Deleting a car

In order to keep my cars accurate (in case of sale or loss) I want to be able to delete cars


### Update Mileage of Vehicle

In order to quickly store current status of vehicle I want to be able to update the mileage of that vehicle

Usage Example:

  > ./maintenance_tracker odo Jetta 129000

  > 2000 Volkswagon Jetta mileage updated to 129000 miles

Acceptance Criteria

  * User passess `odo` command and two arguments to program: name of car
    and miles to update car with
  * New mileage is stored
  * A message confirming the storing of that data is printed out

### Program asks for current mileage and returns next maintenance needed

In order to keep track, and be reminded, of the required maintenance for my car I want to be able to input milage and be returned the upcoming maintenance

Usage Example:

  > ./maintenance_tracker next CRV

  > The next scheduled maintenance for your Honda CRV is: Oil Change at 130000 miles

Acceptance Criteria

* User passes in `next` command and one argument: name of car
* Next maintenance is printed out for that car based on current mileage
  in database

### Adding maintenance

In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

Usage Example:

  > ./maintenance_tracker add "Tire Rotation" 180000 Jetta

  > Tire Rotation scheduled for Volkswagon Jetta at 180000 miles

Acceptance Criteria

* User passes in `new` command followed by the job and miles at which job needs to be completed
* That new maintenance is printed out with the mileage it is schudled at

### View List of All Maintenance

In order to improperly inputted data I want to be able to edit events previously inputted

Usage Example:

  > ./maintenance_tracker list Jetta

  > 1. Oil Change at 180000

  > 2. New Tires at 200000

  > 3. Fuel Filter at 205000

Acceptance Criteria

* User passes in `list` command and one argument: name of car
* A list of all maintenance is printed out

### Deleting Maintenance

In order to remove duplacates and/or unneeded events I want to be able to delete maintenance in database

Usage Example:

  > ./maintenance_tracker deleteMaint

  > For which car?

  Jetta

  > What would you like to delete?

  > 1. Oil Change at 180000

  > 2. New Tires at 200000

  > 3. Fuel Filter at 205000

  > 3

  > "Fuel Filter at 205000" deleted for your 2000 Volkswagon Jetta"

Acceptance Criteria

* User passes in `deleteMaint` command
* The program asks "for which car"
* User enters the name of the car
* Maintenance list is printed out
* User selects which numbered item they want deleted
* That number is removed from the list
* A confirmation of the removal is printed


### Editing Maintenance Already in Database

In order to plan for the future or see what has been accomplished I want to be able to list all maintenence for my vehicle

Usage Example:

  > ./maintenance_tracker editMaint

  > For which car?

  Jetta

  > What would you like to edit?

  > 1. Oil Change at 180000

  > 2. New Tires at 200000

  > 3. Fuel Filter at 205000

  > 3

  > What would you like to change the name or mileage?

  > Name

  > What new name would you like to give it?

  > Cabin Air Filter

  > Item for 2000 Volkswagon Jetta now: Cabin Air Filter at 205000


Acceptance Criteria

* User passes in `editMaint` command
* The program asks "for which car"
* User enters the name of the car
* Maintenance list is printed out
* User selects which numbered item they want edited
* User is asked if they want to edit the name or the milage for that numbered item
* User types in 'name' or 'mileage'
* Program asks what new name or mileage they want to give it
* User types in the new name or mileage
* A printout confirms the new name and mileage of the item
