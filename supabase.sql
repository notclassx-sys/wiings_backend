-- Supabase schema for Wiings Shop

-- Profiles table (links to auth.users)
create table if not exists profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text,
  email text,
  created_at timestamptz default now()
);

-- Admins table (list of admin emails)
create table if not exists admins (
  id serial primary key,
  email text unique not null,
  created_at timestamptz default now()
);

-- Products
create table if not exists products (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text unique,
  description text,
  price numeric(10,2) not null,
  stock int default 0,
  category text,
  image_url text,
  metadata jsonb,
  created_at timestamptz default now()
);

-- Orders
create table if not exists orders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references profiles(id) on delete set null,
  total numeric(10,2) not null,
  status text default 'placed', -- placed, paid, shipped, delivered, cancelled
  shipping_address jsonb,
  payment_provider text,
  payment_intent_id text,
  created_at timestamptz default now()
);

-- Order items
create table if not exists order_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid references orders(id) on delete cascade,
  product_id uuid references products(id) on delete set null,
  quantity int not null,
  unit_price numeric(10,2) not null
);

-- Insert super admin
insert into admins (email) values ('saxenabhavya15@gmail.com') on conflict (email) do nothing;
