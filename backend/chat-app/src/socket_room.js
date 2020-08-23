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

        socket.on('join',({username,room})=>{

            const {error,user} = addUser(socket.id,username,room)

            if(error){
                // have to handle error staff
            }
            else{
                socket.join(room)
                room_users = getUsersInRoom(room)
                room_users = room_users.filter((e)=>e.id!=user.id)
                socket.broadcast.to(room).emit('new_user',user)

                if(room in room_dict){
                    console.log("New websocket connect")
                    socket.broadcast.to(room).emit('message',user.username+' has joined '+user.room)
                    socket.emit("welcome",room_dict[room],room_users)
                }
                else{
                    var current_session_array = []
                    room_dict[room] = current_session_array
                    socket.emit("welcome",room_dict[room],room_users)
                }
            }
        })

        socket.on('sendMessage',(username,room,message)=>{
            var singleMessage = generate_message(username,message)
            room_dict[room].push(singleMessage)
            io.to(room).emit("broadcast",singleMessage)
        })

        socket.on('disconnect',()=>{
            const user = removeUser(socket.id)
            room_users = room_users.filter((e)=>e.id!=user.id)

            if(user){
                io.to(user.room).emit('userLeft',room_users)
            }
        })
    })
}

module.exports = room_socket