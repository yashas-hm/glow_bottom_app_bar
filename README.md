# Glow Bottom App Bar

`GlowBottomAppBar` is a beautiful and easy to use widget which shows a glowing transition from when index changes and is fully customizable.

### **Show some ♥️ and star the repo to support the project**

Resources:
 - [GitHub Repo](https://github.com/yashas-hm/glow_bottom_app_bar)
 - [Example](https://github.com/yashas-hm/glow_bottom_app_bar/tree/main/example)
 - [Pub Package](https://pub.dev/packages/glow_bottom_app_bar)

## Usage

```dart
class DemoScreen extends StatelessWidget {
  const DemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GlowBottomAppBar(
        height: 60,
        onChange: (value) {
          print(value);
        },
        background: Colors.black54,
        iconSize: 35,
        glowColor: Colors.redAccent,
        selectedChildren: const [
          Icon(Icons.ac_unit, color: Colors.redAccent,),
          Icon(Icons.adb_rounded, color: Colors.redAccent,),
          Icon(Icons.account_circle_rounded, color: Colors.redAccent,),
        ],
        children: const [
          Icon(Icons.ac_unit, color: Colors.white,),
          Icon(Icons.adb_rounded, color: Colors.white,),
          Icon(Icons.account_circle_rounded, color: Colors.white,),
        ],
      ),
    );
  }
}
```

### Demo

![Simulator Screen Recording - iPhone 15 Pro Max - 2023-12-20 at 22 12 53](https://github.com/yashas-hm/glow_bottom_app_bar/assets/64674824/95946c22-7ebe-46c2-8f90-8b099c062354)



You can customise `glow_bottom_app_bar` using parameters like:

`height`
`width`
`iconSize`
`duration`
`glowColor`
`background`
`shadowColor`
`children`
`selectedChildren`
`initialIndex`


