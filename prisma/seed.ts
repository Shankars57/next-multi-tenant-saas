import { PrismaClient, Role } from "@prisma/client";
import bcrypt from "bcrypt";

const prisma = new PrismaClient();

async function main() {
  const password = await bcrypt.hash("password123", 10);

  const tenant = await prisma.tenant.upsert({
    where: { slug: "acme-corp" },
    update: {},
    create: {
      name: "Acme Corp",
      slug: "acme-corp",
    },
  });

  await prisma.user.upsert({
    where: { email: "admin@test.com" },
    update: {},
    create: {
      email: "admin@test.com",
      password,
      name: "Admin User",
      role: Role.ADMIN,
      tenantId: tenant.id,
    },
  });

  await prisma.user.upsert({
    where: { email: "member@test.com" },
    update: {},
    create: {
      email: "member@test.com",
      password,
      name: "Member User",
      role: Role.MEMBER,
      tenantId: tenant.id,
    },
  });

  // create some analytics data
  for (let i = 0; i < 10; i++) {
    await prisma.analyticsData.create({
      data: {
        value: Math.random() * 100,
        tenantId: tenant.id,
      },
    });
  }

  console.log("Seeded DB ✅");
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
