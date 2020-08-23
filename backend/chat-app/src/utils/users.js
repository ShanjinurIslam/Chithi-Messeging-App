const users = []

const addUser = (id,username,room)=>{
    username = username.trim().toLowerCase()
    room = room.trim().toLowerCase()

    const existingUser = users.find((user)=>{
        return user.room == room && user.username == username
    })

    if(existingUser){
        return {
            error:'Username is in use'
        }
    }

    const user = {id,username,room}

    console.log(user)

    users.push(user)
    return {user}
}

const removeUser = (id)=>{
    console.log(users,id)
    const index = users.findIndex((user)=>{
        return user.id == id
    })

    if(index!=-1){
        return users.splice(index,1)[0]
    }
}

const getUser = (id)=>{
    const index = users.findIndex((user)=>{
        return user.id == id
    })

    if(index!=-1){
        return users[index]
    }
}

const getUsersInRoom = (room)=>{
    const usersInRoom = users.filter((user)=> user.room == room)

    return usersInRoom
}

module.exports = {addUser,removeUser,getUser,getUsersInRoom}