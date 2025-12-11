# Backend (Express)

Required env vars (see `.env.example`):

- `SUPABASE_URL` - your Supabase project URL
- `SUPABASE_SERVICE_ROLE_KEY` - Supabase service role key (server-side)
- `STRIPE_SECRET_KEY` - Stripe secret key
- `STRIPE_WEBHOOK_SECRET` - Stripe webhook signing secret

API endpoints:

- `GET /` - health
- `GET /api/products` - list products
- `GET /api/products/:id` - get product
- `POST /api/products` - create product (admin only)
- `PUT /api/products/:id` - update product (admin only)
- `DELETE /api/products/:id` - delete (admin only)
- `POST /api/orders` - create order & payment intent
- `POST /api/orders/webhook` - Stripe webhook endpoint

More details & deployment:

Setup:
1. Create a Supabase project and run `supabase.sql` to create tables. Ensure the `admins` table contains the super admin email `saxenabhavya15@gmail.com`.
2. Create a Storage bucket named `products` for product image uploads.
3. Set env vars (see `.env.example`): `SUPABASE_URL`, `SUPABASE_SERVICE_ROLE_KEY`, `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`.

Running locally:

```bash
cd backend
npm install
# create a .env from .env.example and fill values
npm run dev
```

Stripe Webhooks:
- Run `stripe listen --forward-to localhost:4000/api/orders/webhook` while testing locally.

Security notes:
- Never publish the Supabase service role key in the frontend. Backend uses it to perform privileged operations.
- Admin endpoints expect an Authorization header: `Bearer <access_token>` from a Supabase authenticated session. The middleware checks the `admins` table by email.

Admin authentication:

Server checks Authorization: Bearer <access_token> header. The token is validated via Supabase server client, and the user's email is checked against the `admins` table.
