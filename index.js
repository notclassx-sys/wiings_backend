const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')

const app = express()
app.use(cors())
app.use(bodyParser.json())

// Health
app.get('/', (req, res) => res.json({ ok: true, service: 'wiings-shop-backend' }))

// Mount routes
const productsRouter = require('./routes/products')
const ordersRouter = require('./routes/orders')

app.use('/api/products', productsRouter)
app.use('/api/orders', ordersRouter)

const PORT = process.env.PORT || process.env.PORT || 4000
app.listen(PORT, () => console.log(`Backend running on port ${PORT}`))
