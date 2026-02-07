-- init.sql: run by postgres container on first start
CREATE DATABASE appdb;
-- This initial script ensures the container runs an init script as required by the assignment.
-- The application will perform schema push and seeded data using Prisma on startup.
