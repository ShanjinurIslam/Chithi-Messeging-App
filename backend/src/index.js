const express = require('express')
const http = require('http')

const api_router = require('./routers/api')
const socket = require('./socket')

app = express()

server = http.createServer(app)
socket(server)

app.use('/api',api_router)

app.get('/',(req,res)=>{
    return res.status(200).send('Welcome to Chithi Backend')
})

server.listen(3000,"192.168.0.116",()=>{
    console.log("Server started on 192.168.0.116 at port 3000")
})