# 🏠 HomeCheck

> Never leave home wondering if you forgot something.

HomeCheck is a cross-platform Flutter application that helps families make sure everything at home is safe before leaving.

Parents can create customizable checklists for their children (or themselves), while children complete the checklist before leaving home. Parents can monitor progress remotely and receive notifications if important tasks were skipped.

---

## ✨ Features

### Current

- 🌍 English & Russian localization
- 🚀 Feature-first project architecture
- 🧭 GoRouter navigation
- ⚡ Riverpod 3 state management (Notifier API)
- 🎨 Material 3 UI
- 🖼 SVG asset support
- 📱 Initial onboarding screen

### Planned

- 🔐 Authentication
- 👨‍👩‍👧 Parent & Child accounts
- ✅ Smart home checklists
- 🔔 Push notifications
- 📍 Leave-home reminders
- ☁️ Firebase backend
- 📊 Parent dashboard
- 📈 Checklist history
- 🌙 Dark mode

---

# 📸 Screenshots

> Coming soon

---

# 🛠 Tech Stack

- Flutter
- Dart
- Riverpod 3
- GoRouter
- Material 3
- Flutter Localization (gen-l10n)
- flutter_svg
- Google Fonts

Future:

- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging
- Firebase Analytics

---

# 📂 Project Structure

```
mobile/
│
├── assets/
│   ├── icons/
│   ├── illustrations/
│   └── images/
│
├── lib/
│   ├── app/
│   │   ├── providers/
│   │   └── router.dart
│   │
│   ├── core/
│   │
│   ├── features/
│   │   └── onboarding/
│   │
│   ├── l10n/
│   │
│   └── shared/
│
├── test/
│
└── pubspec.yaml
```

---

# 🏗 Architecture

The project follows a Feature-first architecture.

```
Feature
│
├── data
├── domain
└── presentation
```

Application layer:

- app
- core
- shared

This structure keeps every feature isolated and scalable.

---

# 🌍 Localization

Currently supported languages:

- 🇺🇸 English
- 🇷🇺 Russian

Localization is generated using Flutter's built-in **gen-l10n** system.

---

# 🚧 Development Status

## ✅ Completed

- Project initialization
- Feature-first architecture
- Riverpod integration
- GoRouter setup
- Localization (EN/RU)
- Initial onboarding
- SVG support
- Assets structure

## 🔄 In Progress

- Professional onboarding redesign
- Branding
- Language switch
- Design system

## ⏳ Next Milestones

- Authentication
- Parent profile
- Child profile
- Checklist management
- Notifications
- Firebase integration

---

# 📍 Roadmap

- [x] Flutter project setup
- [x] Project architecture
- [x] Riverpod
- [x] GoRouter
- [x] Localization
- [x] Assets structure
- [x] SVG support
- [ ] Design System
- [ ] Professional Onboarding
- [ ] Authentication
- [ ] Home Dashboard
- [ ] Checklist Editor
- [ ] Notifications
- [ ] Firebase Backend
- [ ] Deployment

---

# 🚀 Getting Started

Clone the repository:

```bash
git clone https://github.com/manastokbolatov/home-check.git
```

Open the Flutter project:

```bash
cd home-check/mobile
```

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

---

# 🤝 Contributing

Contributions, ideas and feedback are welcome.

Feel free to open an issue or submit a pull request.

---

# 📄 License

This project is licensed under the MIT License.

---

Made with ❤️ using Flutter.