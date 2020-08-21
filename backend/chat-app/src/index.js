const express = require("express")
const http = require("http")
const path = require("path")
const socketio = require("socket.io")
const { v4: uuidv4 } = require('uuid');


//initialized app
var app = express()

const publicPath = path.join(__dirname, '/public')
console.log(publicPath)

//initialize server 
const server = http.createServer(app)
const io = socketio(server)

app.use('/static',express.static(publicPath))


app.set('views', __dirname + '/views');
app.set('view engine', 'jsx');
app.engine('jsx', require('express-react-views').createEngine());

currentChatSession = ""

io.on('connection',(socket)=>{
    console.log("New websocket connect")
    socket.emit("welcome",currentChatSession)
    socket.broadcast.emit('message','A new user has joined')
    socket.on('sendMessage',(username,message)=>{
        currentChatSession += "<b>"+username+"</b> : "+ message +"<br/>"
        io.emit("broadcast",currentChatSession)
    })

    socket.on('disconnect',()=>{
        io.emit('message','user has left')
    })
})

app.get('/',(req,res)=>{
    res.render('index');
})

app.get('/test',(req,res)=>{
    res.render('broadcast',{ title: 'Broadcast Test' })
})

server.listen(3000,()=>{
    console.log("Connected Successfully")
})




