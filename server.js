const express = require('express');
const needle = require('needle');
const app = express();

app.use(express.json());

app.get('/', function(req, res) {
    if (req.method === 'GET') {
        needle.get(req.webhook, function(_err, response) {
            res.send(response.data);
        });
    };
});

app.post('/', function(req, _res) {
    if (req.method === 'POST') {
        needle.post(req.webhook, req.data);
    } else if (req.method === 'PATCH') {
        needle.patch(req.webhook, req.data);
    } else if (req.method === 'DELETE') {
        needle.delete(req.webhook);
    }
});

app.listen(8080);
