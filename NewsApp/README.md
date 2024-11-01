#  Introduction
NewsApp is a SwiftUI-based news application built using the Clean Architecture approach and the MVVM (Model-View-ViewModel) design pattern. It incorporates dependency injection, actor async/await for concurrency, and Core Data for managing bookmarks.
Note: This is a draft app, with room for future improvements, feature enhancements, and optimizations.
 
## Getting Started
To use the app, you will need an API key from the News API. Replace the API key in the Config class under:
var apiKey: String

## Dependencies
 Swinject - For dependency injection
 Almofire - For network API calls
 
## Architecture
MVVM Design Pattern is used to separate UI and business logic.
Dependency Injection is managed via Swinject. 
All initializers are registered in a container file and resolved in a Coordinator, which handles all navigation for each feature. This structure enhances modularity and ensures each view is isolated from others, with no view managing another.
* **Container ** : All initializers are registered in a container file along with dependency. The initialization of classes/structs specific to one feature are defined in this class.
* **Coordinator ** : The clases/struct registered in the Container are resolved in the Coordinator, hence becoming the first layer of each feature which also manages the navigation.
* **ViewModel ** : Handles the business logic and prepares data for the view.
* **Repository ** : Manages API network calls and response handling, also fetches the coredata data and hence serving as the single source for data interactions.
This approach keeps responsibilities separated, ensuring that each component has a single responsibility and is independent of others.

## Concurrency
Concurrency in NewsApp is handled using actors along with async/await, which allows for safe, performant asynchronous code. This helps prevent data races and ensures thread-safe access to shared resources.

## Dependency Injection
With SwiftInject, dependency injection is streamlined. All dependencies are registered in a container file and injected where needed. The Coordinator uses these dependencies to manage navigation, which results in loosely coupled components.

## Features
* **Top Headline News**: View the latest headlines.
* **Category-based News**: Explore news based on specific categories.
* **Source-based News**: View and filter news articles by source.
* **Bookmarks**: Bookmark articles to read later. Bookmarks can also be viewed and deleted.
Additional Options: While not implemented here, the app also supports fetching news by query, date range, and other criteria.

## Data Persistence
Core Data: Used to save, retrieve, and delete bookmarked articles.


## Testing
Test cases have been implemented for ViewModel classes, ensuring that business logic functions as expected. Each test covers a different part of the app’s core functionalities, verifying that data manipulation and API interactions perform as intended.

##Future Enhancements
The app's architecture supports easy expansion. Future features could include:
News search functionality.
Date range-based filtering.
Additional filtering options for more customized news experiences.

