
var express = require('express');
var router = express.Router();
const cds = require('@sap/cds');

router.get('/endpointAliveTest', async function (req, res) {
    res.json('Up and Running')
});