# maintenance_tracker
NSS Cohort 8 Ruby capstone project

## Project Vision

This is a small command line program that keeps track of completed and upcoming maintenance for the user's vehicles.

Users will be able to add/edit/delete different cars and the maintenance requirements for those cars. The program will give reminders for what's coming up (or what has been missed) based on the current milage of the car. The user can also get a list of completed and upcoming items.

## Features

## Usage

Run the program with `./maintenance_tracker`

A menu will be printed out:

```
1. List Cars
2. List Tasks
3. Current Mileage
4. Update Mileage
5. New Car
6. Edit Car
7. New Task
8. Edit Task
9. Delete Car
10. Delete Task
11. Exit
```

Before each of the following user stories it is understood that the user has passed the above command in

### Adding a new car

In order to track all the vehicles under my purview I want to be able to add new cars to my database

Usage Example:

```
  > 5
  Please enter the year of car
  > 2014
  Please enter the make of car
  > Honda
  Please enter the model of car
  > CRV
  2014 Honda CRV added to database
```

Acceptance Criteria

* User inputs appropriate selection from menu
* Three prompts are printed, asking for year, make, and model of car
* Confirmation is printed showing user's input
* Car is stored in database

### Editing an existing car

In order update a car without having to delete one I want to be able to edit exisiting cars

Usage Example:

```
  > 6
  Which car would you like to edit?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 2
  What would you like to edit: make, model, or year?
  > year
  Please enter the updated year
  > 2001
  2000 Volkswagon Jetta has been updated to 2001 Volkswagon Jetta
```

Acceptance Criteria

* User selects 6: Edit Car
* The program asks which car they would like to change, what they would
  and what they would like to update in menu form
* After answering all prompts a confirmation of changes is printed out


### Deleting a car

In order to keep my cars accurate (in case of sale or loss) I want to be able to delete cars

Usage Example:

```
  >./maintenance_tracker 9
  Which car would you like to delete?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 2
  To confirm, please enter year, make, and model of this car
  > 2012 Honda CRV
  2012 Honda CRV and all maintenance records removed
```

Acceptance Criteria

* User selects 9 from menu
* List of cars printed out and user asked which car they would like
  deleted
* Program asks user to type in Year, Make, and Model as confirmation
* If confirmed, the car and all records are removed from database
* Confirmation is printed out

### View Milage of Vehicle

In order to check on last updated mileage I want to be able to quickly
view the milage on that car

Usage Example:

```
  > 3
  For which car?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 2
  1. 1000 miles on May 20, 2015
  2. 2000 miles on May 20, 2015
```

Acceptance Criteria

* User selects 3 from menu
* List of cars printed out and use asked which one they would like the
  milage for
* The program prints out the mileages for that vehicle


### Update Mileage of Vehicle

In order to quickly store current status of vehicle I want to be able to update the mileage of that vehicle


Usage Example:
```
  > 4
  For which car?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 1
  What is your current milage?
  > 129000
  2000 Volkswagon Jetta mileage updated to 129000 miles
```

Acceptance Criteria

* User selects 4 from menu
* List of cars printed out, user asked which car they would like to
  update
* User enters new milage
* New mileage is stored
* A message confirming the storing of that data is printed out

### List maintenance

In order to ensure the health of my vehicle I want to be able to view all upcoming maintenance items

Usage Example:

```
  > 2
  For which car?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 2
  1. √ Drive it! at 1 miles
  2. √ Oil Change at 123 miles
  3. Air Filter at 2000 miles
  4. Tires at 4321 miles
```

Acceptance Criteria

* User enters 2 at menu
* User enters the number of car they would like the next maintenance for
* All items are printed out, with completed ones having a √ in front of them

### Adding maintenance

In order to keep on top of upcoming maintenance I want to be able to add events based on mileage

Usage Example:

```
  > 7
  For which car?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 1
  What is the name of the task?
  > Oil Change
  At what miles does your Oil Change need to be done?
  > 2000000
  Oil Change for your 2000 Jetta Scheduled at 200000 miles
```

Acceptance Criteria

* User passes 7 to menu
* Program asks for which car, displaying a menu
* The program asks "What is the name of the task"
* The user inputs the appropriate answers scheduled at

### Deleting Maintenance

In order to remove duplicates and/or unneeded events I want to be able to delete maintenance in database

Usage Example:

```
  > 10
  For which car?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
  > 1
  What would you like to delete?
  1. √ Oil Change at 180000
  2. New Tires at 200000
  3. Fuel Filter at 205000
  > 3
  "Fuel Filter at 205000" deleted for your 2000 Volkswagon Jetta"
```

Acceptance Criteria

* User passes 10 to menu
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
  > 8
  For which car?
  1. 2000 Volkswagon Jetta
  2. 2012 Honda CRV
  3. 2014 Chevy Silverado
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

* User passes in 8 to menu
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

Same as previous example, only user inputs `complete`

Acceptance Criteria

* User passes in 8 to menu
* Maintenance list is printed out
* User selects which numbered item they want edited
* User is asked if they want to edit the name, milage, or completed status for that numbered item
* User types in `complete`
* A printout confirms the status of that maintenance item
