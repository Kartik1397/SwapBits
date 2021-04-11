const { Pool } = require('pg')

const pool = new Pool({
  user: 'postgres',
  host: 'db',
  database: 'chatdb',
  password: 'example',
  port: 5432,
  max: 20,
})

module.exports = {
  query: (text, params) => pool.query(text, params),
}