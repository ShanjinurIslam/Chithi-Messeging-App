const express = require("express")
const http = require("http")
const path = require("path")
const socketio = require("socket.io")

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

io.on('connection',()=>{
    console.log("New websocket connect")
})

app.get('/',(req,res)=>{
    res.render('index', { name: 'John' });
})

server.listen(3000,()=>{
    console.log("Connected Successfully")
})




