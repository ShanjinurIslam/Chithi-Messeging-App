const express = require("express")
const path = require("path")

//initialized app
var app = express()

app.set('views', __dirname + '/views');
app.set('view engine', 'jsx');
app.engine('jsx', require('express-react-views').createEngine());

app.get('/',(req,res)=>{
    res.render('index', { name: 'John' });
})

app.listen(3000,()=>{
    console.log("Connected Successfully")
})




