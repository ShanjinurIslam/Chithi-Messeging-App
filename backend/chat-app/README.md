# Using Socket.IO to make a realtime application

## Setup Environment

Install socket.io using ```npm``` 

```bash
npm install socket.io
```

## Integration with node.js

### Server Side Configuration

Add socket.io to ```index.js```

```javascript
const express = require("express")
const http = require("http")
const socketio = require("socket.io")
```

Configure socket.io

```javascript
//initialized app
var app = express()

//initialize server 
const server = http.createServer(app)
const io = socketio(server) //instance of socketio

...

server.listen(3000,()=>{
    console.log("Connected Successfully")
})

```

### Client Side Configuation

Include this to your ```base.jsx``` file

```html
<script src="/socket.io/socket.io.js"></script>
```

Create public folder and create ```/js/chat.js```. and add this also to ```base.jsx```

```javascript
<script src="/static/js/chat.js"></script>
```

Register Static Files with Server

```javascript
const path = require("path")
const publicPath = path.join(__dirname, '/public')
```

Finally inside of ```chat.js``` paste following

```javascript
const socket = io()
```



## Basic Bidirectional Message

In index.js, ```io``` triggers when event is initiated. For suppose, on connection event we can trigger some action to client side

### Server side

```javascript
const message = "Welcome to the Telegram";
io.on('connection',(socket)=>{
    console.log("New websocket connect")
    socket.emit("welcome","Welcome to the Telegram")
  
  	socket.on('greet',(message)=>{
      console.log(message)
    })
})
```

### Client Side 

```javascript
socket.on('welcome',(message)=>{
    console.log(message)
  	socket.emit('greet',"Thank you Server")
})
```

