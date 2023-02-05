const SequenceController = require('../controllers/sequenceController')

module.exports = (app) => {
   app.post('/sequence', SequenceController.post);
   app.put('/sequence', SequenceController.put);
   app.delete('/sequence', SequenceController.delete);
   app.get('/sequence', SequenceController.get);
   app.get('/sequence/:id', SequenceController.getById);
}