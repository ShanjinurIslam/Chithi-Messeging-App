const functions = require('firebase-functions');
//const firebase_admin = require('firebase-admin')
const express = require('express')
const bodyParser = require('body-parser')
const cors = require('cors');

var admin = require("firebase-admin");

var serviceAccount = require("./key.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://chithi-1f0b7.firebaseio.com"
});

db = admin.firestore()

app = express()
app.use(cors({origin:true}))
app.use(bodyParser.json()); // support json encoded bodies
app.use(bodyParser.urlencoded({ extended: true })); // 

app.get('/',(req,res)=>{
    return res.status(200).send("Hello World")
})


// create item
app.post('/api/create', (req, res) => {
    (async () => {
        try {
          await db.collection('items').doc('/' + req.body.id + '/')
              .create({item: req.body.item});
          return res.status(200).send();
        } catch (error) {
          console.log(error);
          return res.status(500).send(error);
        }
      })();
  });

// read item

app.get('/api/read/:id',(req,res)=>{
    (async()=>{
        try{
            const document = await db.collection('items').doc('/'+req.params.id)
            let item = await document.get()
            let response = item.data()
            return res.status(200).send(response)
        }catch(error){
            console.log(error)
            return res.status(500).send(error)
        }
    })();
})

// read all items

app.get('/api/read',(req,res)=>{
    (async()=>{
        try{
            const query = await db.collection('items')
            let response = [];
            await query.get().then(querySnapshot => {
            let docs = querySnapshot.docs;
            for (let doc of docs) {
                const selectedItem = {
                    id: doc.id,
                    item: doc.data().item
                };
                response.push(selectedItem);
            }
            });
            return res.status(200).send(response);
        }catch(error){
            console.log(error)
            return res.status(500).send(error)
        }
    })();
})

app.put('/api/update/:item_id', (req, res) => {
    (async () => {
        try {
            const document = db.collection('items').doc(req.params.item_id);
            await document.update({
                item: req.body.item
            });
            return res.status(200).send();
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
    });
    
// delete
app.delete('/api/delete/:item_id', (req, res) => {
    (async () => {
        try {
            const document = db.collection('items').doc(req.params.item_id);
            await document.delete();
            return res.status(200).send();
        } catch (error) {
            console.log(error);
            return res.status(500).send(error);
        }
        })();
    });


exports.app = functions.https.onRequest(app);


// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
