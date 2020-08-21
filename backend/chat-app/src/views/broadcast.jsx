var React = require('react');
var BaseLayout = require('./layouts/base');
const {Row,Col, Container,Form, FormGroup,Button } = require('react-bootstrap');

function Broadcast(props){
    return (
        <BaseLayout title={props.title}>
            <Container className="text-start" style={{paddingTop:"5%"}}>
                <h2>Welcome to User Broadcast Service</h2>
                <br/>
                <Row>
                    <Col className="col-sm-8">
                        <h3>Send Message</h3> 
                        <Form>
                            <FormGroup>
                                <input id="username" className="form-control" placeholder="Username" ></input>
                            </FormGroup>
                            <FormGroup>
                                <textarea id="message" className="form-control" rows="5" placeholder="Enter Your Message"></textarea>
                            </FormGroup>
                            <FormGroup>
                                <Button id="sendButton" className="btn btn-primary btn-block"><b>Send</b></Button>
                            </FormGroup>
                        </Form>
                    </Col>
                    <Col className="text-right">
                        <h3>Notifications</h3>
                        <div className="overflow-auto" id="notifications"></div>
                    </Col>
                </Row>
                <Row>
                    <Col>
                    <h3>Chat Room</h3>
                    </Col>
                    <Col className="text-right">
                        <button hidden id="serverActive" className="btn btn-outline-success">Server Running</button>
                    </Col>
                </Row>
                <br/>
                <p id="broadcast_message"></p>
            </Container>
        </BaseLayout>
    )
}

module.exports = Broadcast