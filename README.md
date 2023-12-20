# Glow Bottom App Bar
<hr>

Beautiful and easy to use glowing transition bottom app bar which s fully customizable.

#### **Show some ♥️ and star the repo to support the project**

Resources:
 - [GitHub Repo]()
 - [Example]()
 - [Pub Package]()

## Usage
<hr>

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
        // shadowColor: AppColors.white.withOpacity(0.15),
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

You can customise using parameters like:
 - height
 - width
 - iconSize
 - duration
 - glowColor
 - background
 - shadowColor


