var React = require('react');
var BaseLayout = require('./layouts/base');
const { Container, Form, Card, FormGroup, Button } = require('react-bootstrap');

function JoinForm(props) {
    return (
        <Form id="join_room_form" action="/join_room" method="POST">
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

function ErrorAlert(props) {
    if (props.error) {
        return (
            <div className="alert alert-warning alert-dismissible fade show" role="alert">
                <strong>{props.error}</strong>
                <button type="button" className="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
        )
    }
    else {
        return (
            <p></p>
        )
    }
}


function RoomLogIn(props) {
    return (
        <BaseLayout title={props.title} bodyClass="bg-dark">
            <Container style={{ paddingTop: '12%' }}>
                <div style={{ alignItems: 'center', paddingLeft: '30%', paddingRight: '30%' }}>
                    <Card className="text-start bg-light">
                        <div className="card-body">
                            <h3 className="card-title">Join Room</h3>
                            <ErrorAlert error={props.error}></ErrorAlert>
                            <br />
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