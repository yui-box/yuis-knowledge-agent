import postgres from 'postgres'
import { drizzle } from 'drizzle-orm/postgres-js'
import { migrate } from 'drizzle-orm/postgres-js/migrator'

async function main() {
  const client = postgres(process.env.DATABASE_ADMIN_URL!, { max: 1 })
  const db = drizzle(client)

  await migrate(db, { migrationsFolder: 'db/migrations' })
  await client.end()

  console.log('Migrations complete')
}

main().catch((err) => {
  console.error(err)
  process.exit(1)
})
