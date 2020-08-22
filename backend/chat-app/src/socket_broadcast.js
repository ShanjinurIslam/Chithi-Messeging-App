const socketio = require("socket.io")

function broadcast_socket(server){
    const io = socketio(server)
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
}

module.exports = broadcast_socket