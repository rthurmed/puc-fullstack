const express = require('express')
const soap = require('soap')
const fs = require('fs')

const PORT = 8001

const app = express()

const myService = {
    ws: {
        calc: {
            somar: function (args) {
                const n = 1*args.a + 1*args.b
                return {
                    sumres: n
                }
            },
            multiplicar: function (args) {
                const n = 1*args.a * 1*args.b
                return {
                    mulres: n
                }
            },

        }
    }
}

const description = fs.readFileSync('wscalc1.wsdl', 'utf8')

app.listen(PORT, function () {
    soap.listen(app, '/wscalc1', myService, description, function () {
        console.log('server initialized at ' + PORT);
    })
})
