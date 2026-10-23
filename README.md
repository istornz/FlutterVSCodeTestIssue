# Repro: Dart-Code runs the same integration test file twice

Layout mirrors the real setup: a parent folder (`Hub`) and the Flutter project
(`app`) that lives inside it, both opened as folders of one multi-root workspace.

```
FlutterVSCodeTestIssue/          <- folder "Hub"
├── workspaces/repro.code-workspace
└── app/                         <- folder "App" (also inside Hub)
    ├── pubspec.yaml
    ├── lib/main.dart
    └── integration_test/groups_test.dart
```

## Setup (once)

```bash
cd app
flutter create --platforms=android --project-name app .
flutter pub get
```

`flutter create .` keeps the existing `pubspec.yaml`, `lib/main.dart` and the test.

## Repro

1. Plug in an Android device.
2. In VS Code: File > Open Workspace from File... > `workspaces/repro.code-workspace`.
3. Select the device in the status bar.
4. Open `app/integration_test/groups_test.dart` and click the run arrow next to
   `void main()` (or "Run all" in the Test Explorer).

## Expected / observed

- Expected: 6 tests pass one after the other.
- Observed in the real project: tests are reported as errored/skipped at 0.0ms
  while the device is still running them.

## Check for the duplicate session

While the run starts, in another terminal:

```bash
ps -wwaxo pid,ppid,command | grep -E "debug_adapter --test|flutter_tools.snapshot test --machine" | grep -v grep
```

Two `debug_adapter --test` processes (and two `test --machine`) mean the file was
launched once per workspace folder.

## Control

Open only the `app` folder (File > Open Folder... > `app`) and run the same file.
It should start a single session.
