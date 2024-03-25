## Project Documentation

Overview
This Flutter project implements an Ecommerce feature using Clean Architecture principles to ensure modularity, scalability, and maintainability. The project is structured into different layers, including the data layer, domain layer, and presentation layer, to separate concerns and promote code organization.

# Architecture
Clean Architecture
The project follows the Clean Architecture pattern, which consists of three main layers:

Presentation Layer: Contains UI components, including widgets, screens, and blocs responsible for handling user interactions and rendering views.
Domain Layer: Contains business logic and entities that represent core concepts in the application. It is independent of external frameworks and libraries.
Data Layer: Handles data retrieval and manipulation. It includes repositories, data sources, and models for interacting with external data sources.
Data Flow
The data flow in the project follows a unidirectional pattern, with information flowing from the data layer to the presentation layer:

# Data Layer:

Data is retrieved from external sources such as APIs or databases using data sources.
Models are used to represent and serialize/deserialize data.
Repositories abstract data retrieval operations and provide a single source of truth for data access.
Domain Layer:

Business logic and use cases are defined based on domain entities and operations.
Use cases interact with repositories to fetch and manipulate data.
Presentation Layer:

Blocs receive events from UI components and execute corresponding use cases.
UI components subscribe to bloc states and update their views accordingly.
Widgets render UI elements based on the current state provided by blocs.
Folder Structure
The project's folder structure is organized as follows:

lib
core: Contains shared core components, entities, and error handling logic.
features
product: Main module for the Ecommerce feature.
data: Contains data layer components such as models, repositories, and data sources.
domain: Contains domain layer components including entities, use cases, and repositories interfaces.
presentation: Contains presentation layer components such as screens, widgets, and blocs.
test: Includes all unit and widget tests for the project.
Getting Started
To run the project locally, follow these steps:

1, Clone the repository to your local machine.
2, Open the project in your preferred IDE.
3, Run flutter pub get to install dependencies.
4, Run the project using flutter run.