const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp(functions.config().firebase);

exports.sendNotificationToTopic = functions.firestore.document('announcements/{id}').onWrite(async (event) => {
    let title = event.after.get('title');
    let body = event.after.get('description');
    var message = {
        notification: {
            title: title,
            body: body,
        },
        topic: 'alerts',
    };

    let response = await admin.messaging().send(message);
});

exports.sendNotificationToUser = functions.firestore.document('individual-announcements/{id}').onWrite(async (event) => {
    let title = event.after.get('title');
    let body = event.after.get('description');
    var message = {
        notification: {
            title: title,
            body: body,
        },
        topic: event.after.get('topic'),
    };

    let response = await admin.messaging().send(message);
});