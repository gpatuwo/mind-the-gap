
'use strict';

// [START vision_quickstart]
// Imports the Google Cloud client library
const Vision = require('@google-cloud/vision');

// Your Google Cloud Platform project ID
const projectId = 'YOUR_PROJECT_ID';

// Instantiates a client
const visionClient = Vision({
  projectId: projectId
});

// The name of the image file to annotate
const fileName = './resources/wakeupcat.jpg';

// Performs label detection on the image file
visionClient.detectLabels(fileName)
  .then((results) => {
    const labels = results[0];

    console.log('Labels:');
    labels.forEach((label) => console.log(label));
  })
  .catch((err) => {
    console.error('ERROR:', err);
  });
// [END vision_quickstart]
