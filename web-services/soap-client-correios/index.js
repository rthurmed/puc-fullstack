var soap = require('soap')
var correiosURL = 'https://apps.correios.com.br/SigepMasterJPA/AtendeClienteService/AtendeCliente?wsdl'
var cepConsultado = '92200722'


soap.createClient(correiosURL, (err, client) => {
    if (err) return console.log(err)
    // console.log(client.describe().AtendeClienteService.AtendeClientePort);
    client.consultaCEP({ cep: cepConsultado }, (err, result) => {
        if (err) return console.log(err)
        console.log(result)
    })
})
