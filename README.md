# TWProjects

TWProjects is an iOS client app which consumes [Teamwork Projects API](http://developer.teamwork.com/). 

## About Teamwork
[Teamwork](https://www.teamwork.com/) is a company which have a suite of products meant specifically to make Project Management Easy. With **Teamwork Projects** one can do tons of stuff from Creating projects to setting Milestones, from creating and managing events to creating and assigning tasks and what not. Click [here](https://www.teamwork.com/collaboration) to read more about Teamwork Projects


>Although, teamwork projects exposes many APIs but this app stresses only on CRUD operation on Project Entity. However, implementing other APIs won't be a challange now, as the Network Layer interacting with Teamwork Server is fully developed and implementing other APIs is just a matter of adding more of UI and calling Network Layer with appropriate API Resource Path as listed in Documentation

## Purpose

I have developed this app as a part of my [iOS Nanodegree Course](https://www.udacity.com/course/ios-developer-nanodegree--nd003)'s Final Project Submission. The purpose of this app is to make use of following:

* A Networking Layer making REST call to Teamwork Servers. See [API Documentation here.](http://developer.teamwork.com/)
* Demonstration of UIKit framework to layout use of various UI Component which include
  1. Standard iOS UI Controls
  2. MBProgressHUD to show Network Activity
  3. SWRevealViewController to implement SlideIn Menu
  4. Self Sizing Table View Cell to accomodate long text
* Persisting Data on device for quickly loading data on Launch of App. Also syncing persistent store with data at backend in background
* Using animation for better user experience. Used UIPresentationController with animation to present ViewController in bottom half of screen
* Use of Local Notifications to communicate within app.
* A pinch of CoreAnimation to encapsulate heavy weight processing during execution of Login control flow.
 
## How to use the code

To checkout and use this repository follow steps as listed below:
```
$ git clone https://github.com/pritamhinger/TWProjects.git
$ cd TWProjects
```

Double click **TWProjects.xcodeproj** or open the project in Xcode

### Test Data
For purpose of testing this app, i have created a test user. To login into the app using **Test User** use,  **_jupiter581elvis_** as the Secret Key which is asked on Launching the app. 

## Features
1. Login: To Authenticate and authorize User to use the app
2. On Successful Login, Dashboard View Controller is shown. For purpose of submission, Dashboard feature is not implemented
3. The other two menus are, Projects and Latest Activity. This Submission stresses only on Projects Menus. Thus Dashboard and Latest Activity is not implemented for purposes of Submission. Added these Dashboard and Latest Activity to populate Slide In Menu.
4. On Selecting Project Menu, it first load projects from Persistent Store and meanwhile gets Projects from Teamwork servers. Sync persistent Store data with data recieved from Get Call. Update Persistent Store and Update new Data over UI.
5. A project Can be Starred and Unstarred by clicking on the star. A single Tap toggle the state of Star and thereby state of Project. Another single Tap restore the original state of Project
6. Table View show two groups, Starred Projects (only visible if there at least one Starred project) and `Company_Name` Projects (projects owned by company)
7. User can also create a new Project by clicking on the '+' at the top right corner of the screen. This would present a Modal View Controller to create a new Project. 
8. The new View Controller provide UI Control to set Project properties like Title, description, Tags, Category, Start Date and End Date. However for purpose of Submission we are not considering Tags and Category as Teamwork provide separate APIs to fetch available Categories and Tags
9. Selecting a project in project list would open up project for Editing. View Controller has been reused for both New Project Creation as well as Editing existing project.
10. On View Controller to create a new Project, select the Start Date and End Date row to open up custom modal view controller which takes up only half of screen height. 

## License

`TWProjects` is released under an [MIT License] (https://opensource.org/licenses/MIT). See `License` for details
