# iostaskmanagement
A visually appealing and intuitive task management app for iOS devices.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Installation](#installation)
- [Usage](#usage)
- [Requirements](#requirements)
- [Design Decisions](#design-decisions)
- [Future Improvements](#future-improvements)
- [Screenshots](#screenshots)
- [Video Demonstration](#video-demonstration)

## Features

- Modern, sleek interface for managing tasks.
- Three main screens: Task List, Task Details, and Add/Edit Task.
- Visually appealing representation of task priorities (color coding and icons).
- Custom calendar view for task due dates using the CalendarKit library.
- CRUD functionality: Create, Read, Update, and Delete tasks.
- Task categorization (e.g., work, personal).
- Ability to set reminders for tasks with local notifications.
- Dashboard view showing task statistics (completed vs. pending).
- Drag-and-drop functionality for reordering tasks with animation.
- Support for subtasks with an expandable/collapsible UI.

## Technologies Used

- Swift
- SwiftUI
- Core Data for persistent storage
- UserNotifications for managing reminders
- CalendarKit for custom calendar views

## Installation

To run this project locally, follow these steps:

1. Clone this repository:
   git clone https://github.com/yourusername/task-management-app.git

2. Open the project in Xcode:
   open iostaskmanagement.xcodeproj

3. Build and run the app on a simulator or physical device.

## Usage

1. Launch the app on your device or simulator.
2. Create new tasks, categorize them, and set due dates and reminders.
3. Drag and drop tasks to reorder them in the list.
4. View task statistics on the dashboard.
5. Explore task details and edit or delete tasks as needed.

## Requirements

| **Requirement Category** | **Requirement**                                                                                       | **Status**                              | **Notes**                          |
|--------------------------|-------------------------------------------------------------------------------------------------------|-----------------------------------------|------------------------------------|
| **UI/UX (Primary Focus)**| **Design a modern, sleek interface for managing tasks.**                                             | ❌ Not Implemented                          | UI is visually appealing           |
|                          | **Implement at least three screens: Task List, Task Details, and Add/Edit Task.**                    | ❌ Not Implemented                          | All three screens available        |
|                          | **Implement a visually appealing way to represent task priorities (e.g., color coding, icons).**      | ❌ Not Implemented                          | Task priorities are visually represented |
|                          | **Create a custom calendar view for task due dates.**                                                | ❌ Not Implemented                          | CalendarKit is integrated          |
| **Functionality**        | **Allow users to create, read, update, and delete tasks.**                                          | ❌ Not Implemented                          | CRUD operations available           |
|                          | **Implement task categorization (work, personal, etc.).**                                            | ❌ Not Implemented                          | Categories added to task model     |
|                          | **Add the ability to set reminders for tasks.**                                                      | ❌ Not Implemented                          | Reminder functionality added       |
|                          | **Create a dashboard view showing task statistics (e.g., completed vs. pending tasks).**              | ❌ Not Implemented                          | Dashboard view created             |
| **Bonus Points (Optional)** | **Implement data for persistent storage.**                                                        | ❌ Not Implemented                          | Core Data is set up                |
|                          | **Add haptic feedback for user interactions.**                                                        | ❌ Not Implemented                      | Needs implementation               |
|                          | **Create a visually appealing onboarding experience for first-time users.**                           | ❌ Not Implemented                      | Needs implementation               |
|                          | **Implement drag-and-drop functionality for reordering tasks.**                                      | ❌ Not Implemented                          | Drag-and-drop functionality added  |
|                          | **Add support for subtasks with an expandable/collapsible UI.**                                      | ❌ Not Implemented                      | Needs implementation               |

## Design Decisions

- **UI/UX Design**: Focused on a clean, modern look to enhance usability and user experience.
- **Color Coding**: Implemented color-coded priorities for quick visual identification of task importance.
- **Custom Calendar View**: Utilized CalendarKit for an intuitive and interactive calendar experience.
- **Local Notifications**: Used UserNotifications framework for reminders to keep users informed about task deadlines.

## Future Improvements

- later input

## Screenshots

![Task List Screen](path/to/screenshot1.png)
![Task Details Screen](path/to/screenshot2.png)
![Add/Edit Task Screen](path/to/screenshot3.png)
![Dashboard View](path/to/screenshot4.png)

## Video Demonstration

[Link to video demonstration](https://.com)

