import React from 'react';
import ReactDOM from 'react-dom';
import Button from 'react-bootstrap/Button'

class BaseLayout extends React.Component {
    constructor(props) {
        super(props);
    }

    render() {
        return (
            <html>
                <head>
                    <title>{this.props.title}</title>
                    <link
                        rel="stylesheet"
                        href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
                        integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
                        crossOrigin="anonymous"
                    />
                </head>
                <body>
                    {this.props.children}
                    
                </body>
                <script src="/socket.io/socket.io.js"></script>
                <script src="/static/js/chat.js"></script>
            </html>
        );
    };
}

module.exports = BaseLayout