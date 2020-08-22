var React = require('react');
var BaseLayout = require('./layouts/base');
const { Form, Nav, Container, Row, Col, FormGroup } = require('react-bootstrap');


function NavBar(props) {
    return (
        <Nav className="navbar navbar-light bg-light justify-content-between">
            <a className="navbar-brand">{props.title}</a>
            <Form action="/logout" method="POST" className="form-inline">
                <button className="btn btn-outline-danger my-2 my-sm-0" type="submit">Log Out</button>
            </Form>
        </Nav>
    )
}

function Friends(props) {
    var friends = []
    for (var i = 0; i < props.friends.length; i++) {
        friends.push(<a href="#" class="list-group-item list-group-item-action">{props.friends[i]}</a>);
    }
    return friends
}

function Room(props) {
    return (
        <BaseLayout title="Chat Room">
            <NavBar title={props.title}></NavBar>
            <div className="container-fluid pt-4 pl-4">
                <Row>
                    <Col className="col-2">
                        <h5>Active Friend List</h5>
                        <div className="list-group list-group-flush pt-2">
                            <Friends friends={props.activeList}></Friends>
                        </div>
                    </Col>
                    <Col className="col-10">
                        <p>Hello World</p>
                        <form class="form-inline mx-2" style={{ position: "fixed", right: '10px', bottom: '20px' }}>
                            <div class="form-group">
                                <input type="text" class="form-control" placeholder="Enter Your Message" size="80"></input>
                            </div>
                            <div class="form-group mx-2">
                                <button type="submit" class="btn btn-primary">Send Message</button>
                            </div>
                        </form>
                    </Col>
                </Row>
            </div>
        </BaseLayout>
    )
}

module.exports = Room