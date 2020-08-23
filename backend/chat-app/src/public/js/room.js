const chat_box = document.getElementById('chat-box')

var username = document.querySelector('#username').textContent
var room = document.querySelector('#room').textContent.split(' ')[0]
var activeList = document.querySelector('#activeList');

var socket = io()

socket.emit('join',{username,room})

socket.on('userLeft',(room_users)=>{
    room_users = room_users.filter((e) =>{
        e.username != username.trim().toLowerCase()
    })
    console.log(room_users)
    activeList.innerHTML = generateUserList(room_users)
})

socket.on('message',(message)=>{
    console.log(message)
})

const generateActiveUser = (object)=>{
    return `<a href="#" className="list-group-item list-group-item-action">${object.username}</a>`
}   

const generateUserList = (arr)=>{
    var innerHTML = ''
    for(var i=0;i<arr.length;i++){
        innerHTML += generateActiveUser(arr[i])
    }
    return innerHTML
}

socket.on('new_user',(user)=>{
    activeList.innerHTML += generateActiveUser(user)
})

var messages = document.getElementById('messages')

// inputs
var message_box = document.getElementById('message-box')
var sendButton = document.getElementById('sendButton')

// construction of messages

// function to create self message box
function MyMessage(message){
    return `<div class="message-box-holder">
        <div class="message-box">
            ${message}
        </div>
    </div>`
}

// function to create Friend message box

function FriendMessage(username,message) {
    return `<div class="message-box-holder">
        <div class="message-sender">
            ${username}
        </div>
            <div class="message-box message-partner">
                ${message}
        </div>
    </div>`
}

// generate a single message box

function generateMessageBox(object){
    innerHTML = ''
    if(object.username==username){
        innerHTML = MyMessage(object.message)
    }
    else{
        innerHTML = FriendMessage(object.username,object.message)
    }
    return innerHTML
}

// function to generate list of chat
function generateChat(current_session_array){
    var innerHTML = ''
    for(var i=0;i<current_session_array.length;i++){
        var object = current_session_array[i]
        if(object.username==username){
            innerHTML += MyMessage(object.message)
        }
        else{
            innerHTML += FriendMessage(object.username,object.message)
        }
    }
    return innerHTML
}

socket.on('welcome',(current_session_array,users)=>{
    messages.innerHTML = generateChat(current_session_array)
    activeList.innerHTML = generateUserList(users)
    chat_box.scrollTop = chat_box.scrollHeight
})

socket.on('broadcast',(singleMessage)=>{
    messages.innerHTML += generateMessageBox(singleMessage)
    chat_box.scrollTop = chat_box.scrollHeight
})

sendButton.addEventListener('click',(e)=>{
    e.preventDefault()

    written = message_box.value
    message_box.value = ''
    if(written!=""){
        socket.emit('sendMessage',username,room,written)
    }
})
