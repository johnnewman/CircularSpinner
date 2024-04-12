## CircularSpinner

A small SwiftUI package for drawing an animated circular spinner. Enjoy!

CircularSpinner is a stroked circle with an animated puck in its foreground that infinitely spins. The foreground and background can be any ShapeStyle.  By default, the spinner will fill its container's size.

<img src="Git%20Resources/spinners.gif" alt="Example GIF" width="374" height="109" loop=infinite>

### Installation

```Swift
```

#### API
 
You can simply declare a CircularSpinner in your View hierarchy and it will automatically and indefinitely animate. There are two initializers, one that accepts separate background and forground ShapeStyles for the must customization:

```Swift
init(strokeWidth: CGFloat = 10,
     animationDuration: TimeInterval = 1.75,
     diameter: CGFloat? = nil,
     backgroundStyle: Background = Color.secondary,
     foregroundStyle: Foreground = Color.primary)
```
Example use case:
```
CircularSpinner(
    strokeWidth: 15,
    animationDuration: 1,
    backgroundStyle: .white.shadow(.inner(radius: 3)),
    foregroundStyle: .red.shadow(.inner(radius: 3))
)
```

And a second initializer that accepts some premade SpinnerStyles:
```Swift
init(strokeWidth: CGFloat = 10,
     animationDuration: TimeInterval = 1.75,
     diameter: CGFloat? = nil,
     style: SpinnerStyle)
```

Example use case:
```Swift
CircularSpinner(style: .bubbledForeground)
```

#### Premade spinner styles

| `bubbledForeground` | `hierarchy` | `accent` | `nineties` |
| --- | --- | --- | --- |
| ![bubbledForeground](Git%20Resources/bubbledForeground.jpeg) | ![hierarchy](Git%20Resources/hierarchy.jpeg) | ![accent](Git%20Resources/accent.jpeg) | ![nineties](Git%20Resources/nineties.jpeg) |
