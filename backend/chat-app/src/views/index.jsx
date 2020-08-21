var React = require('react');
var BaseLayout = require('./layouts/base');
import { Col, Row,Card,Form,FormGroup,Button } from 'react-bootstrap';

function Index(props) {
  return (
    <BaseLayout title="Chat App">
        <Row>
            <Col className="col-6-sm">
                <div className="text-start" style={{paddingTop:'40%',paddingLeft:'25%'}}>
                        <h1 className="text-primary" >Telegram</h1>
                        <h6 className="text-black" >Send messenges to people aroung the world</h6>
                </div>
            </Col>
            <Col className="col-6-sm">
                <div style={{paddingTop:'25%',paddingLeft:'15%',paddingRight:'25%'}}> 
                    <Card className="text-start shadow p-3 mb-5 bg-white rounded" style={{width:"100%"}}>
                        <div className="card-body">
                            <div className="card-text text-start">
                                <Form>
                                    <FormGroup>
                                        <input type="email" className="form-control" aria-describedby="emailHelp" placeholder="Email"/>
                                    </FormGroup>

                                    <FormGroup>
                                        <input type="password" className="form-control" aria-describedby="emailHelp" placeholder="Password"/>
                                   </FormGroup>
                                        <div className="text-center">
                                            <Button id="logInButton" className="btn btn-primary btn-block"><b>Log In</b></Button>
                                            <br/>
                                            <a className="text-primary" href="#" style={{ fontSize:15}}><b>Forgotten account?</b></a>
                                        </div>
                                </Form>
                                <hr/>
                                <a href="#" className="btn btn-success btn-block"><b>Create New Account</b></a>
                            </div>
                        </div>
                    </Card>
                </div>
            </Col>
            
        </Row>
    </BaseLayout>
    )
}

module.exports = Index;