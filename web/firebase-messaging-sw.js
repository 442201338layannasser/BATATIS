
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

const firebaseConfig = {
    apiKey: "AIzaSyB368vxV3A3qojO6p_Wlyt6jjDFKOWP7_0",
    authDomain: "batatis14-ab827.firebaseapp.com",
    projectId: "batatis14-ab827",
    storageBucket: "batatis14-ab827.appspot.com",
    messagingSenderId: "354908969166",
    appId: "1:354908969166:web:9f1cd18f62e5e3e2df589f",
    measurementId: "G-G25MJ4W9R5"
};

firebase.initializeApp(firebaseConfig);

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
    console.log("onBackgroundMessage", message);
});