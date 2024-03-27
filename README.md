## CircularSpinner

A small SwiftUI package for drawing an animated circular spinner.

The view will infinitely animate a circle with a foreground that spins. The circle foreground and background can be any ShapeStyle. Have fun!

You can create a simple spinner using the default initalizer parameters:
```Swift
CircularSpinner()
```

Or you can get fancy with animations and shapes:
```Swift
CircularSpinner(
    animationDuration: 1.5,
    diameter: 60,
    backgroundStyle: Color.teal,
    foregroundStyle: LinearGradient(
        colors: [.purple, .red],
        startPoint: .leading,
        endPoint: .trailing
    )
)
``` 
