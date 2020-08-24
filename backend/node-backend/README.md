# ```node.js``` Backend and API for Chat Application

## Node Packages Used in this Project

1. Express.js
2. Firebase
3. cors (Cross-origin resource sharing)
4. socket.io

## Firebase Initialization

<b>We’ll assume you already have the Firebase CLI on your machine</b>

```bash
firebase init 
```

Select “Functions” in the options menu. Then select the Firebase App that you created before in the list shown on the next terminal output.

1. Select JavaScript
2. Select yes for linting
3. select yes to install dependencies
and you’re good to go!

## Serverless APIs and your First Endpoint

```bash
cd functions
```

open ```index.js``` and replace existing code with this:

```javascript
const functions = require('firebase-functions');
const firebase_admin = require('firebase-admin')
const express = require('express')
const cors = require('cors');

app = express()
app.use(cors({origin:true}))

app.get('/',(req,res)=>{
    return res.status(200).send("Hello World")
})

exports.app = functions.https.onRequest(app);
```

Now run the app

```bash
npm run serve
```

## CRUD Operations



```javascript
var admin = require("firebase-admin");

var serviceAccount = require("path/to/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://chithi-1f0b7.firebaseio.com"
});
```

## Building out the DB Endpoints

Current APIs

### Create

```javascript
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
```

### Read

```javascript
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
```

### Read all

```javascript
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
```

### Update

```javascript
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
```

### Delete

```javascript
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
```


