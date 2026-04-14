import postgres from 'postgres'
import { drizzle } from 'drizzle-orm/postgres-js'
import { orgs, users } from './schema'

async function main() {
  const client = postgres(process.env.DATABASE_ADMIN_URL!, { max: 1 })
  const db = drizzle(client)

  const [org] = await db.insert(orgs).values({
    name: 'Acme Corp',
  }).returning()

  await db.insert(users).values({
    orgId: org.id,
    email: 'admin@acme.com',
    role: 'yuibot',
  })

  await client.end()

  console.log(`Seeded org "${org.name}" (${org.id})`)
  console.log('Seeded user admin@acme.com')
}

main().catch((err) => {
  console.error(err)
  process.exit(1)
})
