# Krazy Knot

Krazy Knot is a dynamic Flutter application designed for seamless event management, encompassing event creation, member invitations, photo capture, as well as effortless photo sharing and uploading directly within the app.

## Table of Contents
- [Krazy Knot](#krazy-knot)
  - [Table of Contents](#table-of-contents)
  - [Login](#login)
  - [Landing Page](#landing-page)
  - [Menu Drawer](#menu-drawer)
    - [Home](#home)
    - [Event Gallery](#event-gallery)
    - [Social Gallery](#social-gallery)
    - [Scan QR](#scan-qr)
    - [Log Out](#log-out)
  - [Event Creation](#event-creation)
  - [Event Features](#event-features)
    - [Event Details](#event-details)
    - [Event Editing](#event-editing)
  - [Event Link](#event-link)
  - [Guest list](#guest-list)
  - [The name app after being installed](#the-name-app-after-being-installed)

## Login
**Login screen**
Login screen is the first screen that comes into view after the splash screen
The user can login to the app if they have an account registered
 ![Landing](/assets/images/readme/login.png)
  ![Landing](/assets/images/readme/login2.png)
**Sign Up screen**
If the user does not have an account, they can create an account, on successful creation they can log in to the app
 ![Landing](/assets/images/readme/createaccount.png)
  ![Landing](/assets/images/readme/createaccount2.png)
**Forgot password screen**
The user can reset their password and an OTP sent to their registered emails, **N/B Provide a valid email for the OTP to be sent**
 ![Landing](/assets/images/readme/otp.png)
## Landing Page
When you login to the app the following is the first screen that comes into view. The screen shows a greeting with your name as registered, a button to create an event and a list of events that you have created, or a text that instructs that your created events will appear there.
 ![Landing](/assets/images/readme/landing.png)
## Menu Drawer
The menu drawer appears from the left when the menu button is clicked, or by sliding the screen to the right. The menu drawer consists of the following tabs for navigation
  ![Menu Drawer](/assets/images/readme/menudrawer.png)
### Home
The home tab takes you to the [Landing Page](#landing-page)
### Event Gallery
The event gallary tab takes the logged in user to the screen where images can be uploaded or viewed for any event and later shared to the [Social Gallery](#social-gallery) where they can be accessed by other users.
  ![Event Gallery](/assets/images/readme/eventgallery.png)
On clicking the **+ ADD PHOTO** button form the menu drawer, it also takes the user to a different screen where they can upload images for the event
 ![Event Gallery](/assets/images/readme/addphoto.png)

### Social Gallery
The social gallaery consists of images from different users that appear after the event and users can then view or download these images. N/B Not fully implemented
  ![Social Gallery](/assets/images/readme/socialgallery.png)
### Scan QR
The QR code can be scanned in order to access the app via a browser. The purpose of the QR code is for easy access without installing the app.
  ![QR Code](/assets/images/readme/qrcode.png)
### Log Out
The log out button from the drawer menu takes the user to the [login page](#login)
## Event Creation
There is the button that appears at the end of the clipper or the curved design, on clicking the button it takes the user to the event creation screen. On succefully creation, the user is taken back to the home or landing page where they can access the details of the events and make necessary changes or updates.
The user can also select a real location from a map when creating an event
The event creation form takes care of input validation, same case for [Event Editing](#event-editing) form
  ![Create Event](/assets/images/readme/createevent.png)
  ![Create Event](/assets/images/readme/createevent2.png)
  ![Create Event](/assets/images/readme/map.png)
  ![Create Event](/assets/images/readme/validation1.png)
  ![Create Event](/assets/images/readme/validation2.png)
  ![Create Event](/assets/images/readme/validation3.png)
## Event Features
On clicking an event from the list of events that have been created on the [Landing Page](#landing-page), the user gets to access the detail of a single event.
  ![Event list](/assets/images/readme/eventslist.png)
### Event Details
- The event details consists the **current status** that shows if an event is ready, pending, cancelled or has passed 
- A **switch** for updating status to **Ready** or **Pending**
- **Revive button** for reving a **Passed** or **Cancelled** event 
- An **info button** that gives a description of an ongoing event. 
- The event title, type, date schedule, location, and description are also displayed. 
- The helper text at the bottom gives a description based on the status and date of the event. When the event status is ready and date scheduled in future, an **invite friends** button is displayed where the user can invite friends through a link.
- When an event has been canceled, the action **cancel button** on top dissappears meaning that it can either be edited and restored only.
- Notice that the events created come with differet **Colors** and **Images**. This is based on the type of event created, also the **ring** that shows a list of users takes the color of an event card
**Pending Event**
By default an event is created with a **Pending status**
- Event status pending, switch off
- Date scheduled in future
- Helper text that instructs that the event should beready and scheduled to future date
![Pending Event](/assets/images/readme/pending.png)
![Pending Event](/assets/images/readme/pending2.png)

**Ready Event**
On switching the switch on, the event status is updated to ready
- Event status ready, switch on
- Date scheduled in the future
- A button to invite friends
 ![Ready Event](/assets/images/readme/ready.png)
 ![Ready Event](/assets/images/readme/ready2.png)

**Cancelled Event**
On top of event detail screen is a cancel button that chaanges the status of an event to cancel
- Event status is cancelled,  a revive button appears
- Cancel button dissapears once an event has been cancelled
- Helper text - event has been cancelled and can be revived
  ![Cancelled Event](/assets/images/readme/cancelled1.png)
  ![Cancelled Event](/assets/images/readme/cancelled2.png)
  ![Cancelled Event](/assets/images/readme/cancelled3.png)
  ![Cancelled Event](/assets/images/readme/cancelled4.png)

**Passed Event**
The updating of the status to passed happens automatically once the end date of the event is before the current date
- Event status is Passed, Revive buttons appears, cancel button does not dissapear but stilL a passed event cannot be cancelled
- Helper text that the event has passed and can be revived by updating event values
  ![Passed Event](/assets/images/readme/passed.png)
  ![Passed Event](/assets/images/readme/passed2.png)

**Ongoing Event**
Event that is currently happening
- Invite friends button dissapears
- Helper text is shown that this is an ongoing event
- Info button appears, on clicking the info button it tells that to event's status can only be changed by cancelling the ongoing event
  ![Ongoing Event](/assets/images/readme/ongoing.png)
  ![Ongoing Event](/assets/images/readme/ongoing2.png)
  ``
### Event Editing
The events details can be edited by clicking the editing icon which opens the editng screen. The form has pre-fill feature for a specific event which enhances user experience and easy editing. Data is updated immediately on a successful response and the user is taken back to event details screen with updated data
On selecting the location input, the map loads with the current location on the map just like in  [Event Creation](#event-creation)
  ![Event Editing](/assets/images/readme/editing.png)
  ![Event Editing](/assets/images/readme/editing2.png)
## Event Link
On clicking the share button, a link for an event is generated where the user can share it. The link can then be open from a browser when clicked and details of the invittee to be filled for a specific event.
The location on this page is also clickable and can open location on google maps just like in the app.
There are some validations that ensures correctness of data input from the browser form but they are not that good enough. 
The location string from the browser form is also clickable and opens google map location

  ![Link](/assets/images/readme/link1.png)
  ![Link](/assets/images/readme/link2.png)
  ![Link](/assets/images/readme/link3.png)
  ![Link](/assets/images/readme/link4.png)

## Guest list
After members registered for an event from the web form, they are then added to that specific event where the link for the form was generated. In the event details screen, next to the ring that also shows the number of **attendees**, there is a **View Guests** button that opens the Guest screen where the user gets to see a list of members that have accepted the invitation
 ![Link](/assets/images/readme/guests2.png)
 ![Link](/assets/images/readme/guets.png)

## The name app after being installed
 ![Link](/assets/images/readme/krazyknot.png)