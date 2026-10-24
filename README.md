## Prerequisites
- **AWS CLI**: Authenticated with permissions to read SSM parameters and access the S3/DynamoDB remote backend.
- **SSM Parameter**: Create a SecureString parameter in AWS Systems Manager (SSM) named `/dev/rds/db_password` (and `/postgres/db_password` for docker-compose) containing the database password.

## 1. Local Database Setup & Seed
We use a wrapper script to fetch the database password securely from AWS SSM and inject it into Docker Compose at runtime, ensuring no secrets are hardcoded or written to disk.

1. Ensure scripts executable: `chmod +x *.sh; chmod +x ./scripts/*.sh`
2. Start the Postgres database: `./localSetup.sh`
3. The database automatically executes `db/init.sql` on startup, which creates the tables, seeds 150 records using PostgreSQL's `generate_series`, and applies the composite index.

## 2. Query Optimization Explanation
The target query filters by `city` and `created_at`, then groups by `org_id` and `status`:
```sql
SELECT org_id, status, COUNT(*), SUM(amount)
FROM hotel_bookings
WHERE city = 'delhi' AND created_at >= NOW() - INTERVAL '30 days'
GROUP BY org_id, status;