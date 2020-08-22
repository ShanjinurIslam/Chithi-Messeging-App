const join_room_username = document.querySelector('#join_room_username')
const join_room_name= document.querySelector('#join_room_name')
const join_room_button = document.querySelector('#join_room_button')

join_room_button.addEventListener('click',(e)=>{
    console.log("Button pressed")

    if(join_room_username.value == ""){
        alert('empty username')
        return false
    }

    if(join_room_name.value == ""){
        alert('empty room name')
        return false
    }
})