const express = require('express')
const router = express.Router()
const db = require('../db')

router.post('/', async (req, res) => {
  const user = req.body;
  try {
    const { rows } = await db.query(
      'INSERT INTO users (name, email, password, mobile, image_id) VALUES ($1, $2, $3, $4, $5)',
      [user.name, user.email, user.password, user.mobile, user.image_id]
    );

    console.log(rows)

    res.json({
      message: 'User created successfully',
    })
  } catch {
    res.status(500).json({
      'message': 'Failed to execute query'
    });
  }
});

router.get('/', async (req, res) => {
  try {
    const { rows } = await db.query(
      'SELECT * FROM users LIMIT 100'
    );
    res.json({
      message: 'User displayed successfully',
      users: rows
    });
  } catch {
    res.status(500).json({
      'message': 'Failed to execute query'
    });
  }
})

module.exports = router