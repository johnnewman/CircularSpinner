## CircularSpinner

A small SwiftUI package for drawing an animated circular spinner. Enjoy!

CircularSpinner is a stroked background circle with a foreground puck that infinitely spins and oscillates its length between long and short. You can simply declare a CircularSpinner in your View hierarchy and it will automatically and indefinitely animate.

The stroked foreground and background can be any ShapeStyle. This allows for special effects like shadows and gradients. By default, the spinner will fill its container's bounds, but you can supply a diameter to the initializer.

<img src="Git%20Resources/spinners.gif" alt="Example GIF" width="374" height="109" loop=infinite>

#### API
 
There are two initializers. The main initializer offers the most customization, accepting separate background and forground ShapeStyles:

```Swift
/// Initializes an indefinitely animating CircularSpinner.
/// - Parameters:
///   - strokeWidth: The stroke width to use for the spinner background and foreground circles.
///   - animationDuration: The duration of one spin cycle, which rotates the puck 2 full revolutions around the circle.
///   - diameter: The diameter of the spinner. When nil, the spinner fills the container's bounds.
///   - backgroundStyle: The ShapeStyle to apply to the full background circle.
///   - foregroundStyle: The ShapeStyle to apply to the spinning puck.
public init(strokeWidth: CGFloat = 10,
            animationDuration: TimeInterval = 1.75,
            diameter: CGFloat? = nil,
            backgroundStyle: Background = Color.secondary,
            foregroundStyle: Foreground = Color.primary)
```

_Example use case:_
```Swift
CircularSpinner(
    strokeWidth: 15,
    animationDuration: 1,
    backgroundStyle: .white.shadow(.inner(radius: 3)),
    foregroundStyle: .red.shadow(.inner(radius: 3))
)
```

#### Premade styles 

There is a second initializer that accepts a premade SpinnerStyle:
```Swift
public init(strokeWidth: CGFloat = 10,
            animationDuration: TimeInterval = 1.75,
            diameter: CGFloat? = nil,
            style: SpinnerStyle)
```

_Example use case:_
```Swift
CircularSpinner(style: .bubbledForeground)
```

Here is an example of each SpinnerStyle:

| `bubbledForeground` | `hierarchy` | `accent` | `nineties` |
| --- | --- | --- | --- |
| <img src="Git%20Resources/bubbledForeground.jpg" alt="bubbledForeground" width="90" height="90"> | <img src="Git%20Resources/hierarchy.jpg" alt="hierarchy" width="90" height="90"> | <img src="Git%20Resources/accent.jpg" alt="accent" width="90" height="90"> | <img src="Git%20Resources/nineties.jpg" alt="nineties" width="90" height="90"> |
