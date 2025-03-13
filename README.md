# ✅ Simple To-Do App with Firebase & Google Authentication

A modern **To-Do List application** built with **Flutter** that integrates **Firebase Authentication** and **Cloud Firestore** to store tasks persistently across user sessions. Users can sign in with **Google**, add tasks, mark them as complete, and reorder them based on priority.

## 🎯 Features
- 🔐 **Google Sign-In** for user authentication  
- 📂 **Cloud Firestore Database** to store tasks  
- ✅ **Add, Delete, and Mark Tasks as Complete**  
- 📌 **Reorder Tasks** (Drag & Drop) with Firestore persistence  
- 🔄 **Auto Refresh on User Login/Logout** (No need for manual refresh)  
- 🎨 **Beautiful UI with Flutter**  

---

## 📦 **Tech Stack**
- **Flutter** (Frontend)
- **Firebase Authentication** (User Login)
- **Cloud Firestore** (Database)
- **Google Sign-In** (OAuth)
- **Reorderable ListView** (Task reordering)

---

## 🚀 **Setup Instructions**
### **1️⃣ Prerequisites**
- Install **Flutter**: [Install Guide](https://flutter.dev/docs/get-started/install)
- Install **Firebase CLI**:  
  ```sh
  npm install -g firebase-tools


2️⃣ Clone the Repository
sh
Copy
Edit
git clone https://github.com/yourusername/simple-todo-app.git
cd simple-todo-app


3️⃣ Setup Firebase
Go to Firebase Console → Create a new project.
Enable Authentication → Choose Google Sign-In.
Enable Cloud Firestore.
Download the google-services.json (for Android) and GoogleService-Info.plist (for iOS) and place them inside android/app/ and ios/Runner/ respectively.


4️⃣ Configure Firebase in Flutter
Run the following command to set up Firebase in your Flutter project:
sh
Copy
Edit
flutterfire configure


5️⃣ Install Dependencies
sh
Copy
Edit
flutter pub get


6️⃣ Run the App
sh
Copy
Edit
flutter run -d chrome
