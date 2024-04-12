## CircularSpinner

A small SwiftUI package for drawing an animated circular spinner. Enjoy!

CircularSpinner is a stroked circle with an animated puck in its foreground that infinitely spins and toggles its length. You can simply declare a CircularSpinner in your View hierarchy and it will automatically and indefinitely animate.

The stroked foreground and background can be any ShapeStyle. By default, the spinner will fill its container's bounds, but you can supply a diameter to the initializer.

<img src="Git%20Resources/spinners.gif" alt="Example GIF" width="374" height="109" loop=infinite>

#### API
 
There are two initializers, one that offers the most customization, accepting separate background and forground ShapeStyles:

```Swift
/// Initializes the CircularSpinner, which will indefinitely animate.
/// - Parameters:
///   - strokeWidth: The stroke width to use for the circle.
///   - animationDuration: The duration of a spin cycle that rotates 2 revolutions.
///   - diameter: The diameter of the spinner.
///   - backgroundStyle: The ShapeStyle to apply to the full background circle.
///   - foregroundStyle: The ShapeStyle to apply to the spinning circle.
public init(strokeWidth: CGFloat = 10,
            animationDuration: TimeInterval = 1.75,
            diameter: CGFloat? = nil,
            backgroundStyle: Background = Color.secondary,
            foregroundStyle: Foreground = Color.primary)
```

_Example use case:_
```
CircularSpinner(
    strokeWidth: 15,
    animationDuration: 1,
    backgroundStyle: .white.shadow(.inner(radius: 3)),
    foregroundStyle: .red.shadow(.inner(radius: 3))
)
```

There is a second initializer that accepts a premade SpinnerStyle:
```Swift
init(strokeWidth: CGFloat = 10,
     animationDuration: TimeInterval = 1.75,
     diameter: CGFloat? = nil,
     style: SpinnerStyle)
```

_Example use case:_
```Swift
CircularSpinner(style: .bubbledForeground)
```

Here is an example of each style:

| `bubbledForeground` | `hierarchy` | `accent` | `nineties` |
| --- | --- | --- | --- |
| <img src="Git%20Resources/bubbledForeground.jpg" alt="bubbledForeground" width="155" height="155"> | <img src="Git%20Resources/hierarchy.jpg" alt="hierarchy" width="155" height="155"> | <img src="Git%20Resources/accent.jpg" alt="accent" width="155" height="155"> | <img src="Git%20Resources/nineties.jpg" alt="nineties" width="155" height="155"> |
