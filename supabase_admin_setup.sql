-- CM STUDIO FULL ADMIN SETUP
-- Run in your Supabase project's SQL Editor (privileged SQL Editor, NOT in the browser).
-- 1. Create an administrator account in Authentication > Users.
-- 2. Run this script.
-- 3. Replace the UUID in the final INSERT with that user's real auth.users UUID and run it.
-- Public can read ONLY published projects. Only allowlisted admins can create/edit/delete.
-- Never place a service_role key in website code.

create table if not exists public.cm_admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade,
  added_at timestamptz not null default now()
);
alter table public.cm_admin_users enable row level security;
-- No direct access policy: this table is managed by SQL Editor only.

create or replace function public.is_cm_admin()
returns boolean language sql stable security definer
set search_path = ''
as $$
  select exists(select 1 from public.cm_admin_users where user_id = (select auth.uid()));
$$;
revoke all on function public.is_cm_admin() from public;
grant execute on function public.is_cm_admin() to authenticated;


-- Home / Index
create table if not exists public.portfolio_projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Home / Index',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.portfolio_projects add column if not exists category text not null default 'Home / Index';
alter table public.portfolio_projects add column if not exists image_url text;
alter table public.portfolio_projects add column if not exists published boolean not null default false;
alter table public.portfolio_projects add column if not exists sort_order integer not null default 0;
alter table public.portfolio_projects add column if not exists created_at timestamptz not null default now();
alter table public.portfolio_projects enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published portfolio_projects" on public.portfolio_projects;
drop policy if exists "Public can read published portfolio_projects" on public.portfolio_projects;
drop policy if exists "CM published read" on public.portfolio_projects;
drop policy if exists "CM admin read" on public.portfolio_projects;
drop policy if exists "CM admin insert" on public.portfolio_projects;
drop policy if exists "CM admin update" on public.portfolio_projects;
drop policy if exists "CM admin delete" on public.portfolio_projects;
create policy "CM published read" on public.portfolio_projects
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.portfolio_projects
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.portfolio_projects
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.portfolio_projects
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.portfolio_projects
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.portfolio_projects to anon;
grant select, insert, update, delete on public.portfolio_projects to authenticated;

-- Graphic Design
create table if not exists public.graphic_showcase (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Graphic Design',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.graphic_showcase add column if not exists category text not null default 'Graphic Design';
alter table public.graphic_showcase add column if not exists image_url text;
alter table public.graphic_showcase add column if not exists published boolean not null default false;
alter table public.graphic_showcase add column if not exists sort_order integer not null default 0;
alter table public.graphic_showcase add column if not exists created_at timestamptz not null default now();
alter table public.graphic_showcase enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published graphic_showcase" on public.graphic_showcase;
drop policy if exists "Public can read published graphic_showcase" on public.graphic_showcase;
drop policy if exists "CM published read" on public.graphic_showcase;
drop policy if exists "CM admin read" on public.graphic_showcase;
drop policy if exists "CM admin insert" on public.graphic_showcase;
drop policy if exists "CM admin update" on public.graphic_showcase;
drop policy if exists "CM admin delete" on public.graphic_showcase;
create policy "CM published read" on public.graphic_showcase
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.graphic_showcase
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.graphic_showcase
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.graphic_showcase
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.graphic_showcase
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.graphic_showcase to anon;
grant select, insert, update, delete on public.graphic_showcase to authenticated;

-- Brand Identity
create table if not exists public.brand_showcase (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Brand Identity',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.brand_showcase add column if not exists category text not null default 'Brand Identity';
alter table public.brand_showcase add column if not exists image_url text;
alter table public.brand_showcase add column if not exists published boolean not null default false;
alter table public.brand_showcase add column if not exists sort_order integer not null default 0;
alter table public.brand_showcase add column if not exists created_at timestamptz not null default now();
alter table public.brand_showcase enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published brand_showcase" on public.brand_showcase;
drop policy if exists "Public can read published brand_showcase" on public.brand_showcase;
drop policy if exists "CM published read" on public.brand_showcase;
drop policy if exists "CM admin read" on public.brand_showcase;
drop policy if exists "CM admin insert" on public.brand_showcase;
drop policy if exists "CM admin update" on public.brand_showcase;
drop policy if exists "CM admin delete" on public.brand_showcase;
create policy "CM published read" on public.brand_showcase
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.brand_showcase
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.brand_showcase
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.brand_showcase
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.brand_showcase
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.brand_showcase to anon;
grant select, insert, update, delete on public.brand_showcase to authenticated;

-- Social Media Design
create table if not exists public.social_showcase (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Social Media Design',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.social_showcase add column if not exists category text not null default 'Social Media Design';
alter table public.social_showcase add column if not exists image_url text;
alter table public.social_showcase add column if not exists published boolean not null default false;
alter table public.social_showcase add column if not exists sort_order integer not null default 0;
alter table public.social_showcase add column if not exists created_at timestamptz not null default now();
alter table public.social_showcase enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published social_showcase" on public.social_showcase;
drop policy if exists "Public can read published social_showcase" on public.social_showcase;
drop policy if exists "CM published read" on public.social_showcase;
drop policy if exists "CM admin read" on public.social_showcase;
drop policy if exists "CM admin insert" on public.social_showcase;
drop policy if exists "CM admin update" on public.social_showcase;
drop policy if exists "CM admin delete" on public.social_showcase;
create policy "CM published read" on public.social_showcase
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.social_showcase
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.social_showcase
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.social_showcase
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.social_showcase
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.social_showcase to anon;
grant select, insert, update, delete on public.social_showcase to authenticated;

-- Photography
create table if not exists public.photography_showcase (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Photography',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.photography_showcase add column if not exists category text not null default 'Photography';
alter table public.photography_showcase add column if not exists image_url text;
alter table public.photography_showcase add column if not exists published boolean not null default false;
alter table public.photography_showcase add column if not exists sort_order integer not null default 0;
alter table public.photography_showcase add column if not exists created_at timestamptz not null default now();
alter table public.photography_showcase enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published photography_showcase" on public.photography_showcase;
drop policy if exists "Public can read published photography_showcase" on public.photography_showcase;
drop policy if exists "CM published read" on public.photography_showcase;
drop policy if exists "CM admin read" on public.photography_showcase;
drop policy if exists "CM admin insert" on public.photography_showcase;
drop policy if exists "CM admin update" on public.photography_showcase;
drop policy if exists "CM admin delete" on public.photography_showcase;
create policy "CM published read" on public.photography_showcase
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.photography_showcase
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.photography_showcase
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.photography_showcase
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.photography_showcase
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.photography_showcase to anon;
grant select, insert, update, delete on public.photography_showcase to authenticated;

-- Printing Solutions
create table if not exists public.printing_showcase (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Printing Solutions',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.printing_showcase add column if not exists category text not null default 'Printing Solutions';
alter table public.printing_showcase add column if not exists image_url text;
alter table public.printing_showcase add column if not exists published boolean not null default false;
alter table public.printing_showcase add column if not exists sort_order integer not null default 0;
alter table public.printing_showcase add column if not exists created_at timestamptz not null default now();
alter table public.printing_showcase enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published printing_showcase" on public.printing_showcase;
drop policy if exists "Public can read published printing_showcase" on public.printing_showcase;
drop policy if exists "CM published read" on public.printing_showcase;
drop policy if exists "CM admin read" on public.printing_showcase;
drop policy if exists "CM admin insert" on public.printing_showcase;
drop policy if exists "CM admin update" on public.printing_showcase;
drop policy if exists "CM admin delete" on public.printing_showcase;
create policy "CM published read" on public.printing_showcase
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.printing_showcase
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.printing_showcase
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.printing_showcase
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.printing_showcase
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.printing_showcase to anon;
grant select, insert, update, delete on public.printing_showcase to authenticated;

-- Website Design
create table if not exists public.website_showcase (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null default 'Website Design',
  image_url text not null,
  published boolean not null default false,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);
alter table public.website_showcase add column if not exists category text not null default 'Website Design';
alter table public.website_showcase add column if not exists image_url text;
alter table public.website_showcase add column if not exists published boolean not null default false;
alter table public.website_showcase add column if not exists sort_order integer not null default 0;
alter table public.website_showcase add column if not exists created_at timestamptz not null default now();
alter table public.website_showcase enable row level security;
-- Clear previously created policies on this specific table, to avoid accidental permissive writes.
-- Review any additional custom policies separately in Supabase before launch.
drop policy if exists "Public read published website_showcase" on public.website_showcase;
drop policy if exists "Public can read published website_showcase" on public.website_showcase;
drop policy if exists "CM published read" on public.website_showcase;
drop policy if exists "CM admin read" on public.website_showcase;
drop policy if exists "CM admin insert" on public.website_showcase;
drop policy if exists "CM admin update" on public.website_showcase;
drop policy if exists "CM admin delete" on public.website_showcase;
create policy "CM published read" on public.website_showcase
 for select to anon, authenticated using (published = true);
create policy "CM admin read" on public.website_showcase
 for select to authenticated using ((select public.is_cm_admin()));
create policy "CM admin insert" on public.website_showcase
 for insert to authenticated with check ((select public.is_cm_admin()));
create policy "CM admin update" on public.website_showcase
 for update to authenticated using ((select public.is_cm_admin())) with check ((select public.is_cm_admin()));
create policy "CM admin delete" on public.website_showcase
 for delete to authenticated using ((select public.is_cm_admin()));
grant select on public.website_showcase to anon;
grant select, insert, update, delete on public.website_showcase to authenticated;

-- Public image hosting, with admin-only uploads.
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('cm-portfolio', 'cm-portfolio', true, 10485760, array['image/jpeg','image/png','image/webp','image/gif'])
on conflict (id) do update set public = true, file_size_limit = 10485760,
  allowed_mime_types = array['image/jpeg','image/png','image/webp','image/gif'];

drop policy if exists "CM admin upload images" on storage.objects;
drop policy if exists "CM admin update images" on storage.objects;
drop policy if exists "CM admin delete images" on storage.objects;
create policy "CM admin upload images" on storage.objects
 for insert to authenticated
 with check (bucket_id = 'cm-portfolio' and (select public.is_cm_admin()));
create policy "CM admin update images" on storage.objects
 for update to authenticated
 using (bucket_id = 'cm-portfolio' and (select public.is_cm_admin()))
 with check (bucket_id = 'cm-portfolio' and (select public.is_cm_admin()));
create policy "CM admin delete images" on storage.objects
 for delete to authenticated
 using (bucket_id = 'cm-portfolio' and (select public.is_cm_admin()));

-- ADMIN ALLOWLIST: REPLACE UUID BELOW WITH AUTHENTICATION > USERS > USER UID.
-- Do not run the following line until you have replaced the placeholder.
-- insert into public.cm_admin_users (user_id)
-- values ('00000000-0000-0000-0000-000000000000')
-- on conflict (user_id) do nothing;
