#  SKyVPN - A VPN Registartion App using SwiftUI

## Features
1. login user
2. Registartion user
3. Logout user
4. Reset user password

## Requirements

**iOS 14.0+ / macOS 10.14.4
**Xcode 12+
**Swift 5+

 ## Architecture
 
 ** We have used MVVM Architecture. Model–view–viewmodel (MVVM) is a software architectural pattern. MVVM facilitates a separation of development of the graphical user interface – be it via a markup language or GUI code – from development of the business logic or back-end logic (the data model).

## Swift UI
SwiftUI is an innovative, exceptionally simple way to build user interfaces across all Apple platforms with the power of Swift. Build user interfaces for any Apple device using just one set of tools and APIs. With a declarative Swift syntax that’s easy to read and natural to write, SwiftUI works seamlessly with new Xcode design tools to keep your code and design perfectly in sync. Automatic support for Dynamic Type, Dark Mode, localization, and accessibility means your first line of SwiftUI code is already the most powerful UI code you’ve ever written.

## Components
### Views
1. Login 
   This controller will be the responsible for the login user
2. Router
   This is the main Viewcontroller , this controller will decide the application flow from starting
3. Home
    After succesfull user login user will reach this view
4. SignUp
    This controller will be the responsible for the registartion of user
 
### ViewModel
ViewModel interacts with model and also prepares observable(s) that can be observed by a View. One of the important implementation strategies of this layer is to decouple it from the View, i.e, ViewModel should not be aware about the view who is interacting with.

1. AuthVM
   VM interact with API handler and Data Handler for the requested datat from the controller
       
### NetWorkService
this is the network layer create to handle the API calls. Every request will goes this layer.


### ThirdParties
1. Alamofire


All the license are mentioned in the Utilities/License.txt file

### Code management
Used gitflow method in this repository.
Gitflow Workflow is a Git workflow that helps with continuous software development and implementing DevOps practices. It was first published and made popular by Vincent Driessen at nvie. The Gitflow Workflow defines a strict branching model designed around the project release. This provides a robust framework for managing larger projects. 

     

## How To Install
1. Clone the repository using git clone command : git clone https://github.com/muneerkk66/SkyVPN.git (you can also use ssh/github CLI ).
2. Go to project directory
3. install pod using cocopod App or using terminal command
4. Open project Workspace then run the code.




