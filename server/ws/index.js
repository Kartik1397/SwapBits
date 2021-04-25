const db = require('../db');
const WebSocket = require('ws');

const wss = new WebSocket.Server({ port: 4001 });

const user_socket = {}

wss.on('connection', (ws) => {
  ws.on('message', async (msg) => {
    const req = JSON.parse(msg);
    switch (req.type) {
      case 'open':
        user_socket[req.uid] = ws;
        break;
      case 'send_msg':
        const { uid, receiver_id, msg } = req;

        if (receiver_id in user_socket) {
          const receiver_sock = user_socket[receiver_id];
          const obj = {
            type: 'recv_msg',
            msg: msg
          }

          try {
            const { rows } = await db.query(
              'INSERT INTO messages (sender_id, receiver_id, message, type) VALUES ($1, $2, $3, $4)',
              [uid, receiver_id, msg.content, msg.type]
            );
        
            console.log('Message inserted.')
          } catch {
            console.log('Fail to insert message.')
          }
          user_socket[uid].send(JSON.stringify({ type: 'status', msg: "sent" }))
          user_socket[receiver_id].send(JSON.stringify(obj));
        }
      default:
    }
  })
});

module.exports = wss;
