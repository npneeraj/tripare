CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE hotel_bookings (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  org_id UUID NOT NULL,
  hotel_id VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  checkin_date DATE NOT NULL,
  checkout_date DATE NOT NULL,
  amount NUMERIC(12,2) NOT NULL,
  status VARCHAR(50) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE booking_events (
  id BIGSERIAL PRIMARY KEY,
  booking_id UUID NOT NULL,
  event_type VARCHAR(100) NOT NULL,
  payload JSONB,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

-- Optimization Index
-- Covers the WHERE clause (city, created_at) and supports the GROUP BY (org_id, status)
CREATE INDEX idx_hotel_bookings_city_created_org ON hotel_bookings (city, created_at DESC, org_id, status);

-- Seed Data Generation
DO $$
DECLARE
    cities text[] := ARRAY['delhi', 'mumbai', 'bangalore', 'chennai'];
    statuses text[] := ARRAY['CONFIRMED', 'CANCELLED', 'PENDING'];
    orgs uuid[] := ARRAY[uuid_generate_v4(), uuid_generate_v4(), uuid_generate_v4()];
    hotels text[] := ARRAY['hotel-A', 'hotel-B', 'hotel-C', 'hotel-D'];
    v_booking_id uuid;
BEGIN
    FOR i IN 1..150 LOOP
        v_booking_id := uuid_generate_v4();
        
        INSERT INTO hotel_bookings (id, org_id, hotel_id, city, checkin_date, checkout_date, amount, status, created_at)
        VALUES (
            v_booking_id,
            orgs[ceil(random() * 3)],
            hotels[ceil(random() * 4)],
            cities[ceil(random() * 4)],
            CURRENT_DATE + (random() * 30)::int,
            CURRENT_DATE + 30 + (random() * 10)::int,
            round((random() * 1000 + 50)::numeric, 2),
            statuses[ceil(random() * 3)],
            NOW() - (random() * 60 * interval '1 day')
        );

        INSERT INTO booking_events (booking_id, event_type, payload, created_at)
        VALUES (
            v_booking_id,
            'BOOKING_CREATED',
            '{"source": "web"}'::jsonb,
            NOW()
        );
    END LOOP;
END $$;