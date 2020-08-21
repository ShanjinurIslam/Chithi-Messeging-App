import React from 'react';
import ReactDOM from 'react-dom';

class BaseLayout extends React.Component{
    constructor(props){
        super(props);
    }

    render(){
        return (
            <html>
              <head><title>{this.props.title}</title></head>
              
              <body>{this.props.children}</body>
            </html>
        );
    };
}

module.exports = BaseLayout