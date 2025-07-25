# Initial Design and Assumptions

## Assumptions
- We are not going to need translations. We will put the user displayed strings in a class to make refactoring easier later
- We will be developing for Android only
- The task says not to worry too much about aesthetics, so we will be focussing mostly on functionality and building a base that would be easy to polish in the future
- As this is a small project, we will keep everything as part of the same package and keep the folder structure simple
- Having a look at the API, there is not a websocket or gRPC implementation. As the task states that "This data should be as up to date as is reasonably possible", we will likely want to implement some sort of polling functionality.

## Technologies
- Bloc for state management
- Dio for networking
- json_serializable for json serialisation

## MVP
- Loads data from API
- Displays relevant error and loading states
- Has a graph for the current day

## Stretch goals
- Offline first