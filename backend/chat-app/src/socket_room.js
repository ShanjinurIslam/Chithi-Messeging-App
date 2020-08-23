const socketio = require("socket.io")

// welcome members
// prebuilt as a broadcast first to check the stying and codes
function generate_message(username,message){
    return {
        username:username,
        message:message,
        //time:Date.now().toString()
    }
}

function room_socket(server){
    const io = socketio(server)

    var current_session_array = []

    io.on('connection',(socket)=>{
        console.log("New websocket connect")
        socket.emit("welcome",current_session_array)

        /*
        socket.on('join',(username)=>{
            current_users_in_session.push(username)
            socket.broadcast.emit('activeList',current_users_in_session)
        })*/

        socket.on('sendMessage',(username,message,callback)=>{
            var singleMessage = generate_message(username,message)
            current_session_array.push(singleMessage)
            io.emit("broadcast",singleMessage)
            callback('Delivered at '+new Date().toLocaleTimeString())
        })
    })
}

module.exports = room_socket