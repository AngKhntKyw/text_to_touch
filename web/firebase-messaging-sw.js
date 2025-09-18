// Import and configure the Firebase SDK
// This is a minimal implementation of a service worker that will only work for Firebase Messaging.
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging-compat.js');

// Initialize the Firebase app in the service worker
// by passing in the messagingSenderId.
const firebaseConfig = {
    apiKey: 'AIzaSyBXbZMY1vwPm_dWiUy_cdekMhgGM-xOfRA',
    appId: '1:398314793727:web:1856a09fa59fa4af31faca',
    messagingSenderId: '398314793727',
    projectId: 'text-to-touch',
    authDomain: 'text-to-touch.firebaseapp.com',
    storageBucket: 'text-to-touch.firebasestorage.app',
};

firebase.initializeApp(firebaseConfig);


// Retrieve an instance of Firebase Messaging so that it can handle background messages.
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});