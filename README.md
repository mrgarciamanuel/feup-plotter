# FEUP PLOTTER
## Getting Started

1. Install from pub.deb

```bash
    flutter pub add feup_plotter
```

2. After that you can use elements everywhere importing in the file:
```bash
    import 'package:feup_plotter/feup_plotter.dart'
```

3. Data preparation
You can plot information for single element of you can make comparison between two elements.
- You need six variables:
    - names: describe elements
    - colors: array of Color type - to distinguish elements visually
    - labels: array string - markers for X axis
    - result: int array with values that an element can have based on labels
    - appBarBgColor: variable of type Color to define the color of appbar
    - screenTitle: String variable with title of screen
- Then call our FeupPlotter widget with these parameter to get everything working.

4. Find example in file: example/lib/main.dart
5. Charts
 
    At moment we support three types of chart:
   - Line
   - Bar
   - Area
  


https://github.com/user-attachments/assets/9b7fed82-541e-4261-9dc5-b327bded9227


## Contributors and maintainers

<a href="https://github.com/mrgarciamanuel/feup-plotter/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=mrgarciamanuel/feup-plotter" />
</a>
