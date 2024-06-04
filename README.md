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

![Simulator Screenshot - iPhone SE (3rd generation) - 2024-05-24 at 02 16 25](https://github.com/mrgarciamanuel/feup-plotter/assets/100171179/74b48518-66e7-4534-8cdd-019f8da4d5ad)
![Simulator Screenshot - iPhone SE (3rd generation) - 2024-05-24 at 02 13 54](https://github.com/mrgarciamanuel/feup-plotter/assets/100171179/8a0fbe79-0558-4fa5-ae29-8412da3bc2d9)
![Simulator Screenshot - iPhone SE (3rd generation) - 2024-05-24 at 02 14 14](https://github.com/mrgarciamanuel/feup-plotter/assets/100171179/0567eda3-9c17-4b73-b330-536b9d195fe4)
![Simulator Screenshot - iPhone SE (3rd generation) - 2024-05-24 at 02 14 24](https://github.com/mrgarciamanuel/feup-plotter/assets/100171179/3ccd165b-6f3f-48ca-8778-e7cbf8199d8c)


