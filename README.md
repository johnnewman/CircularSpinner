## CircularSpinner

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjohnnewman%2FCircularSpinner%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/johnnewman/CircularSpinner) [![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fjohnnewman%2FCircularSpinner%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/johnnewman/CircularSpinner)

A Swift package for drawing an animated circular spinner in SwiftUI. Enjoy!

CircularSpinner is a stroked background circle with a spinning foreground puck. The puck's length oscillates between long and short at each spin cycle. You can simply declare a CircularSpinner in your View hierarchy and it will automatically animate.

The stroked foreground and background can be any ShapeStyle. This allows for special effects like shadows and gradients to be applied to either layer. By default, the spinner will fill its container's bounds, but you can supply a diameter to the initializer.

<img src="Git%20Resources/spinners.gif" alt="Example GIF" width="374" height="109" loop=infinite>

### API
 
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

### Premade styles 

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
