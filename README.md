---
runme:
  id: 01HR4HBVPYMRQ4A2PD1B169J54
  version: v3
---

# flutter_starter

A reusable flutter starter template that contains all standard-features of a multi-platform app.

1. [Localizations](https://pub.dev/packages/easy_localization)
2. [Routing](https://pub.dev/packages/go_router)
3. [State-management](https://pub.dev/packages/riverpod)

## Installation

Pro tip: Install [runme](https://docs.runme.dev/installation/installrunme) to run all the steps below automatically

1. Install [fvm](https://fvm.app/documentation/getting-started/installation) and run:

```bash {"id":"01HR4HBVPYMRQ4A2PD11GE050F"}
fvm use
```

2. Check if everything is setup properly

```bash {"id":"01HR4HBVPYMRQ4A2PD158W0XBQ"}
fvm doctor
```

```bash {"id":"01HR4HBVPYMRQ4A2PD184VKME4"}
fvm flutter doctor
```

3. Run the build_runner to build generated files

```bash {"id":"01HR4HCXRQDBPZA1HMNWPSDBD6"}
fvm dart run build_runner build --delete-conflicting-outputs
```