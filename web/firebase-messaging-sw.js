// Firebase messaging service worker for push notifications
importScripts('https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging-compat.js');

firebase.initializeApp({
  apiKey: "AIzaSyDiAQHwCK9dJZcr6qsFiQk92XvNy69Clv8",
  authDomain: "daily-zikr-app.firebaseapp.com",
  projectId: "daily-zikr-app",
  storageBucket: "daily-zikr-app.firebasestorage.app",
  messagingSenderId: "749174344298",
  appId: "1:749174344298:web:84c958fa71af98c2955813"
});

const messaging = firebase.messaging();

// Handle background messages
messaging.onBackgroundMessage((payload) => {
  console.log('Received background message:', payload);

  const notificationTitle = payload.notification?.title || 'Daily Zikr';
  const notificationOptions = {
    body: payload.notification?.body || 'Time for your adhkar!',
    icon: '/icons/Icon-192.png',
    badge: '/icons/Icon-192.png',
    tag: 'daily-zikr-reminder',
    requireInteraction: true,
    data: payload.data
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});

// Handle notification click
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  
  event.waitUntil(
    clients.matchAll({ type: 'window', includeUncontrolled: true }).then((clientList) => {
      // If app is already open, focus it
      for (const client of clientList) {
        if (client.url.includes('daily-zikr-app.web.app') && 'focus' in client) {
          return client.focus();
        }
      }
      // Otherwise open new window
      if (clients.openWindow) {
        return clients.openWindow('/');
      }
    })
  );
});
