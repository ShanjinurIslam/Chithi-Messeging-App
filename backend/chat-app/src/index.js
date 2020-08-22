const express = require("express")
const http = require("http")
const path = require("path")
const socketio = require("socket.io")
const bodyParser = require('body-parser')

const { v4: uuidv4 } = require('uuid');
const { time } = require("console");
const { title } = require("process")

var cookieSession = require('cookie-session')

var Filter = require('bad-words')
filter = new Filter();

//initialized app
var app = express()


//initialize server 
const server = http.createServer(app)

const publicPath = path.join(__dirname, '/public')

app.use(cookieSession({
    name: 'session',
    keys: ['key1','key2'],
    // Cookie Options
    maxAge: 24 * 60 * 60 * 1000, // 24 hours,
    path:'/',
    httpOnly:true
  }))

app.use(bodyParser.urlencoded({ extended: true }))
app.use('/static',express.static(publicPath))
app.set('views', __dirname + '/views');
app.set('view engine', 'jsx');
app.engine('jsx', require('express-react-views').createEngine());

const broadcast_io = require('./socket_broadcast')
broadcast_io(server)

app.get('/',(req,res)=>{
    res.render('index');
})

app.get('/join_room',(req,res)=>{
    if(req.session.username){
        return res.redirect('/room')
    }
    res.render('room_login');
})

app.post('/join_room',(req,res)=>{
    const username = req.body.username
    const room = req.body.room

    if(username=="" || room == ""){
        return res.render('room_login',{error:'username/room name missing'})
    }
    req.session.username = username
    req.session.room = room
    res.redirect('/room')
})

app.get('/room',(req,res)=>{
    if(!req.session.username){
        return res.redirect('/join_room')
    }
    res.render('room',{title:req.session.room+' Room',activeList:['Frank','Abby','Joel','Elly']})
})

app.post('/logout',(req,res)=>{
    req.session = null
    res.redirect('/join_room')
})

app.get('/test',(req,res)=>{
    res.render('broadcast',{ title: 'Broadcast Test' })
})

server.listen(3000,()=>{
    console.log("Connected Successfully")
})




