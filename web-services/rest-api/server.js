const express = require('express')

const PORT = 3010

const app = express()

app.use(express.json())
app.use(express.urlencoded({ extended: true }));
app.listen(PORT, function () {
    console.log('server initialized at ' + PORT);
})

require('./src/routes/index')(app)
