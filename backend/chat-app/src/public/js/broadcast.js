/*
const socket = io()

const serverActive = document.getElementById("serverActive")
const notificationBlock = document.getElementById("notifications")

socket.on('welcome',(message)=>{
    serverActive.hidden = false
    broadcast_messages.innerHTML = message
})

socket.on('message',(message)=>{
    notificationBlock.innerHTML += "<div class=\"alert alert-warning alert-dismissible fade show\" role=\"alert\"><strong>"+message+" !</strong><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button></div>"
})

const username = document.getElementById("username")
const message = document.getElementById("message")
const sendButton = document.getElementById("sendButton")
const sendLocationButton = document.getElementById("sendLocationButton")

const broadcast_messages = document.getElementById("broadcast_message")

socket.on('broadcast',(message)=>{
    broadcast_messages.innerHTML = message
})


sendButton.addEventListener('click',(e)=>{
    e.preventDefault()

    const u = username.value
    const m =  message.value

    if(u=="" || m==""){
        alert('Empty Username/Message Box')
    }
    else{
        message.value = ""
        username.readOnly = true
        socket.emit('sendMessage',u,m,(message)=>{
            console.log("Delivery Message: ",message)
        })
    }
})
*/