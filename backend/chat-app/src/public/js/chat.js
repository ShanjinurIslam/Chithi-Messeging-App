const socket = io()

socket.on('welcome',(message)=>{
    console.log(message)
    socket.emit('greet',"Thank you Server")
})

socket.on('new_member',(message)=>{
    console.log(message)
})

const logInButton = document.getElementById("logInButton")

logInButton.addEventListener('click',()=>{
})