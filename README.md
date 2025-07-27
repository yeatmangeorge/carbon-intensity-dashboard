# Carbon Intensity Dashboard

## Running

This project uses code gen for json serialisation. run the following before building.

```bash
flutter pub run build_runner build
```

Afterwards, you can run:

```bash 
flutter run
```

The project is designed for Android only.

## Assumptions

Before starting coding, I analysed the requirements docs and had a look at the api. I noted any assumptions and plans
in [initial design and assumptions](design/initial_design_and_assumptions.md)

## State of the project

This project is currently in a non-functional state. I ran out of time due to spending too much time building for the
future of the project, rather than focussing on the MVP. Additionally, I overestimated how much I could achieve in the
given time due to not having developed in Flutter for a while.

## Improvements

- Fix bugs
- Improve UI and theme
- Add a proper localisation package
- Use a dependency injection framework, rather than manually injecting
- Modularize codebase
- Expand error handling

## Lessons Learnt

- When given short deadlines, I should prioritise functionality rather than laying foundations for future development.
- I completed the time for this task in small blocks I had free. Because of this, I had to spend time getting my head
  back into the project, which made me less effective. In the future, I should try schedule the time so that I complete
  the work in less blocks of time, to reduce time spent getting my head back into the project.