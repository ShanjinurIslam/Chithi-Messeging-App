var React = require('react');
var BaseLayout = require('./layouts/base');

function Room(props){
    return (
        <BaseLayout title={props.title} bodyClass="bg-light">
            <p>Hello World</p>
        </BaseLayout>
    )
}