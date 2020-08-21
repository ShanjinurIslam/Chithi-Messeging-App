var React = require('react');
var BaseLayout = require('./layouts/base');

function Index(props) {
  return (
    <BaseLayout title="Chat App">
        <div>Hello {props.name}</div>
    </BaseLayout>
    )
}

module.exports = Index;