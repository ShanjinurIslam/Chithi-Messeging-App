const socketio = require('socket.io')

function chat_socket(server){
    const io = socketio(server)

    io.on("connection",(userSocket)=>{
        userSocket.on("send_message", (data) => {
            userSocket.broadcast.emit("receive_message", data)
        })
    })
}

module.exports = chat_socket