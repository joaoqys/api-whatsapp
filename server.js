const express = require('express');
const venom = require('venom-bot');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

const port = 3000

venom
  .create({
    session: 'session-name'
  })
  .then((client) => start(client))
  .catch((erro) => {
    console.log(erro);
  });

function start(client) {
  app.post("/enviar-mensagem", async (req, res) => {
    const { to, message } = req.body;
    await client.sendText(to + '@c.us', message);
    res.json("mensagem enviada")
  })
}

app.listen(port, () => {
  console.log(`API rodando na porta ${port}`);
});
