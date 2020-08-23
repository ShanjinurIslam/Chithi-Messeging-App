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
            socket.join(room)

            if(room in room_dict){
                console.log("New websocket connect")
                socket.broadcast.to(room).emit('message',username+'has joined '+room)
                socket.emit("welcome",room_dict[room])
            }
            else{
                var current_session_array = []
                room_dict[room] = current_session_array
                socket.emit("welcome",room_dict[room])
            }
        })

        socket.on('sendMessage',(username,room,message)=>{
            console.log(username,room,message)
            var singleMessage = generate_message(username,message)
            room_dict[room].push(singleMessage)
            io.to(room).emit("broadcast",singleMessage)
        })

        /*
        socket.on('join',(username)=>{
            current_users_in_session.push(username)
            socket.broadcast.emit('activeList',current_users_in_session)
        })*/
        
        /*
        socket.on('sendMessage',(username,message,callback)=>{
            var singleMessage = generate_message(username,message)
            current_session_array.push(singleMessage)
            io.emit("broadcast",singleMessage)
            callback('Delivered at '+new Date().toLocaleTimeString())
        })*/
    })
}

module.exports = room_socket