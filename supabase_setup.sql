-- Execute isso no SQL Editor do Supabase:
-- https://app.supabase.com → seu projeto → SQL Editor

create table if not exists public.guests (
  id           uuid        default gen_random_uuid() primary key,
  name         text        not null,
  food         text[],        -- array: múltiplos itens possíveis
  food_custom  text,
  drink        text[],        -- array: múltiplas bebidas possíveis
  drink_custom text,
  created_at   timestamptz default now()
);

-- Row Level Security
alter table public.guests enable row level security;

create policy "Leitura pública"
  on public.guests for select to anon using (true);

create policy "Inserção pública"
  on public.guests for insert to anon with check (true);

create policy "Remoção pública"
  on public.guests for delete to anon using (true);

-- Realtime
alter publication supabase_realtime add table public.guests;

-- ── Se você já criou a tabela com a versão anterior (food text), rode isso: ──
-- alter table public.guests drop column if exists confirmed;
-- alter table public.guests alter column food  type text[] using array[food]::text[];
-- alter table public.guests alter column drink type text[] using array[drink]::text[];
