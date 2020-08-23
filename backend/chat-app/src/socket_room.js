const socketio = require("socket.io");
const {addUser,removeUser,getUser,getUsersInRoom} = require('./utils/users')

const users = []

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
    var room_dict = {};
    const io = socketio(server)

    io.on('connection',(socket)=>{

        socket.on('join',({username,room},callback)=>{

            console.log(username,room)

            const {error,user} = addUser(socket.id,username,room)

            socket.join(room)

            if(error){
                return callback(error)
            }

            if(room in room_dict){
                console.log("New websocket connect")
                socket.broadcast.to(room).emit('message',user.username+' has joined '+user.room)
                socket.emit("welcome",room_dict[room])
            }
            else{
                var current_session_array = []
                room_dict[room] = current_session_array
                socket.emit("welcome",room_dict[room])
            }

            callback()
        })

        socket.on('sendMessage',(username,room,message)=>{
            var singleMessage = generate_message(username,message)
            room_dict[room].push(singleMessage)
            io.to(room).emit("broadcast",singleMessage)
        })

        socket.on('disconnect',()=>{
            const user = removeUser(socket.id)
            console.log(user)
            if(user){
                io.to(user.room).emit('message',user.username+'has left')
            }
        })
    })
}

module.exports = room_socket