import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

export const helloWorld = functions.https.onRequest((request, response) => {
    response.send("Hello from Firebase!");
});
admin.initializeApp();
export const voteListener =
    functions.firestore.document('/elections/{electionName}/posts/{postName}/candidates/{candidateName}/votes/{voteId}')
        .onWrite(async (change, context) => {
            const postName = await admin.firestore().collection('elections').doc(context.params.electionName).collection('posts').doc(context.params.postName).get().then((ds) => {
                return ds.id;
            })
            const candidateName = await admin.firestore().collection('elections').doc(context.params.electionName).collection('posts').doc(context.params.postName).collection('candidates').doc(context.params.candidateName).get().then((ds) => {
                return ds.id;
            });

            if (!change.before.exists) {
                // New document Created : add one to count


                return admin.firestore().collection('elections').doc(context.params.electionName).collection('posts').doc(postName).collection('candidates').doc(candidateName).
                    update({ noOfVotes: admin.firestore.FieldValue.increment(1) });

            } else if (change.before.exists && change.after.exists) {
                // Updating existing document : Do nothing

            } else if (!change.after.exists) {
                // Deleting document : subtract one from count

                return admin.firestore().collection('elections').doc(context.params.electionName).collection('posts').doc(postName).collection('candidates').doc(candidateName).
                    update({ noOfVotes: admin.firestore.FieldValue.increment(-1) });
            }

            return;
        });