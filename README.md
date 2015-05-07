# maintenance_tracker
NSS Cohort 8 Ruby capstone project

## Project Vision

This will be a small command line program that keeps track of completed and upcoming maintenance for the user's vehicles.

Users will be able to add/edit/delete different cars and the maintenance requirements for those cars. The program will give reminders for what's coming up (or what has been missed) based on the current milage of the car. The user can also get a list of completed and upcoming items.

## Features

### Update Mileage of Vehicle

In order to quickly store current status of vehicle I want to be able to update the mileage of that vehicle

Usage Example:

  > ./maintenance_tracker odo 129000
  
  > Current mileage updated to 129000 miles
  
Acceptance Criteria

  * User passess two arguments to program, a command and a mileage amount
  * That mileage amount is stored on the vehicle
  * A message confirming the storing of that data is printed out

### Program asks for current mileage and returns next maintenance needed

In order to keep track, and be reminded, of the required maintenance for my car I want to be able to input milage and be returned the upcoming maintenance

Usage Example:

  > ./maintenance_tracker next
  
  > The next scheduled maintenance for your car is: Oil Change at 130000 miles
  
Acceptance Criteria

* User passes in `next` argument
* Next maintenance is printed out for that car based on milage provided
  
### Adding maintenance

In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

Usage Example:

  > ./maintenance_tracker new "Tire Rotation" 180000
  
  > Tire Rotation scheduled for 180000 miles
  
Acceptance Criteria

* User passes in `new` command followed by the job and miles at which job needs to be completed
* That new maintenance is printed out with the mileage it is schudled at

### View List of All Maintenance

In order to improperly inputted data I want to be able to edit events previously inputted

Usage Example:

  > ./maintenance_tracker list
  
  > 1. Oil Change at 180000

  > 2. New Tires at 200000

  > 3. Fuel Filter at 205000

Acceptance Criteria

* User passes in `list` command
* A list of all maintenance is printed out

### Deleting Maintenance

In order to remove duplacates and/or unneeded events I want to be able to delete maintenance in database

Usage Example:

  > ./maintenance_tracker delete
  
  What would you like to delete?
  
  1. Oil Change at 180000
  
  2. New Tires at 200000
  
  3. Fuel Filter at 205000
  
  > 3
  "Fuel Filter at 205000" deleted"
  
Acceptance Criteria

* User passes in `delete` command
* Maintenance list is printed out
* User selects which numbered item they want deleted
* That number is removed from the list
* A confirmation of the removal is printed


### Editing Maintenance Already in Database

In order to plan for the future or see what has been accomplished I want to be able to list all maintenence for my vehicle

Usage Example:

  > ./maintenance_tracker edit
  What would you like to edit?
  1. Oil Change at 180000
  2. New Tires at 200000
  3. Fuel Filter at 205000
  > 3
  What would you like to change the name or mileage?
  > Name
  What new name would you like to give it?
  > Cabin Air Filter
  Item now: Fuel Filter at 205000
  
  
Acceptance Criteria

* User passes in `edit` command
* Maintenance list is printed out
* User selects which numbered item they want edited
* User is asked if they want to edit the name or the milage for that numbered item
* User types in 'name' or 'mileage'
* Program asks what new name or mileage they want to give it
* User types in the new name or mileage
* A printout confirms the new name and mileage of the item


### Adding a new car

In order to track all the vehicles under my purview I want to be able to add new cars to my database

### Editing an existing car

In order update a car without having to delete one I want to be able to edit exisiting cars

### Deleting a car

In order to keep my cars accurate (in case of sale or loss) I want to be able to delete cars

