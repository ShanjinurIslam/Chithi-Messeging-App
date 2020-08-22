var React = require('react');
var BaseLayout = require('./layouts/base');
const { Container, Form,Card,FormGroup,Button } = require('react-bootstrap');

function JoinForm(props) {
    return (
        <Form action="/join_room" method="POST">
            <FormGroup>
                <h6 className="card-subtitle mb-2 text-muted">Display Name</h6>
                <input id="join_room_username" name="username" className="form-control" placeholder="Username" ></input>
            </FormGroup>
            <FormGroup>
                <h6 className="card-subtitle mb-2 text-muted">Room</h6>
                <input id="join_room_name" name="room" className="form-control" placeholder="Room" ></input>
            </FormGroup>
            <FormGroup>
                <button id="join_room_button" type="submit" className="btn btn-primary btn-block"><b>Join</b></button>
            </FormGroup>
        </Form>
    )
}


function RoomLogIn(props){
    return (
        <BaseLayout title={props.title} bodyClass="bg-dark">
            <Container style={{paddingTop:'12%'}}>
                <div style={{alignItems:'center',paddingLeft:'37%',paddingRight:'37%'}}>
                    <Card className="text-start bg-light">
                        <div className="card-body">
                            <h3 className="card-title">Join Room</h3>
                            <br/>
                            <JoinForm>
                            </JoinForm>
                        </div>
                    </Card>
                </div>
            </Container>
        </BaseLayout>
    )
}

module.exports = RoomLogIn