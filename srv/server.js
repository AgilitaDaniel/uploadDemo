const cds = require("@sap/cds");
const express = require("express");
// const xsenv = require('@sap/xsenv')
const soapHandler = require('./soaphandler')
const bodyParser = require('body-parser');
require('body-parser-xml')(bodyParser);

cds.on("bootstrap", (app) => { 
    app.use(express.urlencoded({ extended: true }));
app.use(bodyParser.xml({
    limit:'25MB'
}));
    app.get('/endpointAliveTest', async function (req, res) {
        res.json('Up and Running')
    });
    app.post('/soap/mySoapIncoming', async function (req, res) {
        console.log(req.body)
        res.json('Up and Running')

    });
});
module.exports = cds.server;