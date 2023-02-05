var soap = require('soap');

var calculatorURL = 'http://www.dneonline.com/calculator.asmx?wsdl';

soap.createClient(calculatorURL, function (err, client) {
    console.log('DESCRIÇÃO DO WSDL: ');
    console.log(client.describe().Calculator.CalculatorSoap);

    client.Add({ intA: 1, intB: 2 }, function (err, result) {
        if (err) return console.log(err)
        console.log('A soma é: ', result.AddResult)
    })

    client.Divide({ intA: 20, intB: 8 }, function (err, result) {
        if (err) return console.log(err)
        console.log('A divisão é: ', result.DivideResult)
    })
})
