CREATE TYPE  Role AS ENUM ('ADMIN', 'MEMBER');

CREATE TABLE IF NOT EXISTS Tenant (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS User (
  id SERIAL PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  name TEXT,
  role Role NOT NULL,
  tenantId INTEGER NOT NULL REFERENCES Tenant(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS AnalyticsData (
  id SERIAL PRIMARY KEY,
  value DOUBLE PRECISION NOT NULL,
  timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  tenantId INTEGER NOT NULL REFERENCES Tenant(id) ON DELETE CASCADE
);

INSERT INTO Tenant (name, slug)
VALUES ('Acme Corp', 'acme-corp')
ON CONFLICT (slug) DO NOTHING;

INSERT INTO User (email, password, name, role, tenantId)
VALUES
  ('admin@test.com', '', 'Admin User', 'ADMIN', (SELECT id FROM Tenant WHERE slug='acme-corp')),
  ('member@test.com', '', 'Member User', 'MEMBER', (SELECT id FROM Tenant WHERE slug='acme-corp'))
ON CONFLICT (email) DO NOTHING;

INSERT INTO AnalyticsData (value, tenantId)
VALUES
  (42.5, (SELECT id FROM Tenant WHERE slug='acme-corp')),
  (77.1, (SELECT id FROM Tenant WHERE slug='acme-corp')),
  (13.2, (SELECT id FROM Tenant WHERE slug='acme-corp'))
ON CONFLICT DO NOTHING;
