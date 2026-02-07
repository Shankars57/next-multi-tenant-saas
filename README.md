# Multi-Tenant SaaS Platform (Next.js 14)

This project is a full multi-tenant SaaS scaffold built with Next.js 14 (App Router), Prisma, PostgreSQL, NextAuth v5, Docker, and Server Actions.

## Features
- Multi-tenant routing: /tenants/{tenantSlug}/...
- RBAC: ADMIN and MEMBER
- NextAuth v5 credentials auth via Server Actions
- RSC + streaming dashboard widgets
- SSE real-time feed endpoint
- CSV export endpoint
- Search + pagination with URL sync
- Intercepting route modal
- Parallel routes for analytics & support
- Health check API
- Error boundary handling

## Requirements
- Docker + Docker Compose
- Node.js 20+ (for local dev)

## Quick Start (Docker)
1. Copy envs
`
cp .env.example .env
`

2. Build and run
`
docker-compose up --build
`

The database is seeded automatically via /docker-entrypoint-initdb.d/seed.sql.

## Local Development
1. Install deps
`
npm install
`

2. Set envs
`
cp .env.example .env
`

3. Generate Prisma client
`
npm run prisma:generate
`

4. Push schema & seed
`
npm run db:push
npm run prisma:seed
`

5. Run dev server
`
npm run dev
`

## Test Credentials
- Admin
  - Email: dmin@test.com
  - Password: password123
- Member
  - Email: member@test.com
  - Password: password123
- Tenant slug: cme-corp

## Key Routes
- / login
- /tenants/{tenantSlug}/dashboard
- /tenants/{tenantSlug}/data
- /profile
- /api/health
- /api/events
- /api/export
- /faulty-page

## Required Files
- Dockerfile
- docker-compose.yml
- .env.example
- submission.json
- prisma/schema.prisma
- prisma/seed.sql
- pp/*

## Notes
- All interactive UI elements include required data-testid attributes.
- The CSV export endpoint returns export.csv with a header and at least one row.
- SSE uses data: {json}\n\n framing.
