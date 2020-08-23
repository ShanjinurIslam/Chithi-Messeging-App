var React = require('react');
var BaseLayout = require('./layouts/base');
const { Form, Nav, Container, Row, Col, FormGroup } = require('react-bootstrap');


function NavBar(props) {
    return (
        <Nav className="navbar navbar-light bg-light justify-content-between">
            <a id="room" className="navbar-brand">{props.title}</a>
            <Form action="/logout" method="POST" className="form-inline">
                <div className="mr-2">
                    Logged In as 
                    <strong id="username" className="ml-2">{props.username}</strong>
                </div>
                
                <button className="btn btn-outline-danger my-2 my-sm-0" type="submit">Log Out</button>
            </Form>
        </Nav>
    )
}

/*
function Friends(props) {
    var friends = []
    for (var i = 0; i < props.friends.length; i++) {
        
    }
    return friends
}*/

function Room(props) {
    return (
        <BaseLayout title="Chat Room" script="/static/js/room.js">
            <NavBar title={props.title} username={props.username}></NavBar>
            <div className="container-fluid pt-4 pl-4">
                <Row>
                    <Col className="col-2">
                        <h5>Active Friend List</h5>
                        <div id="activeList" className="list-group list-group-flush pt-2">
                        </div>
                    </Col>
                    <Col className="col-10">
                        <div id="chat-box" className="pre-scrollable">
                            <div id="messages" className="chat-messages">
                            </div>
                        </div>
                        <form className="form-inline mx-2" style={{ position: "fixed", right: '10px', bottom: '20px' }}>
                            <div className="form-group">
                                <input id="message-box" type="text" className="form-control" placeholder="Enter Your Message"></input>
                            </div>
                            <div className="form-group mx-2">
                                <button id="sendButton" type="submit" className="btn btn-primary">Send Message</button>
                            </div>
                        </form>
                    </Col>
                </Row>
            </div>
        </BaseLayout>
    )
}

module.exports = Room