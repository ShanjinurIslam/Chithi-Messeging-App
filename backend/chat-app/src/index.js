const express = require("express")
const http = require("http")
const path = require("path")
const socketio = require("socket.io")
const bodyParser = require('body-parser')
const { v4: uuidv4 } = require('uuid');
const { time } = require("console");
const { title } = require("process")
var Filter = require('bad-words'),

filter = new Filter();

//initialized app
var app = express()

const publicPath = path.join(__dirname, '/public')
console.log(publicPath)

app.use(bodyParser.urlencoded({ extended: true }))

//initialize server 
const server = http.createServer(app)
const io = socketio(server)

app.use('/static',express.static(publicPath))


app.set('views', __dirname + '/views');
app.set('view engine', 'jsx');
app.engine('jsx', require('express-react-views').createEngine());

/*

currentChatSession = ""

io.on('connection',(socket)=>{
    console.log("New websocket connect")

    socket.emit("welcome",currentChatSession)
    
    socket.broadcast.emit('message','A new user has joined')

    socket.on('sendMessage',(username,message,callback)=>{
        if(filter.isProfane(message)){
            callback("Profane is not allowed")
        }
        else{
            currentChatSession += "<b>"+username+"</b> : "+ filter.clean(message) +"<br/>"
            io.emit("broadcast",currentChatSession)
            callback('Delivered at '+new Date().toLocaleTimeString())
        }
    })

    socket.on('disconnect',()=>{
        io.emit('message','user has left')
    })
})

*/

app.get('/',(req,res)=>{
    res.render('index');
})

app.post('/join_room',(req,res)=>{
    console.log(req.body)
    res.render('room_login',title=req.body['room']);
})

app.get('/join_room',(req,res)=>{
    res.render('room_login');
})

app.get('/room',(req,res)=>{
    res.render('room')
})

app.get('/test',(req,res)=>{
    res.render('broadcast',{ title: 'Broadcast Test' })
})

server.listen(3000,()=>{
    console.log("Connected Successfully")
})




