CREATE SCHEMA IF NOT EXISTS;
inventory_management_analytics

-- ============================================
-- Sites
-- ============================================

CREATE TABLE IF NOT EXISTS inventory_management_analytics.Sites (
    site_id TEXT,
    region TEXT,
    consumption_tier TEXT,
    restock_cycle_days INTEGER
);

-- ============================================
-- Items
-- ============================================

CREATE TABLE IF NOT EXISTS inventory_management_analytics.Items (
    item_id TEXT,
    item_name TEXT,
    category TEXT,
    unit TEXT, 
    supplier_lead_time_days INTEGER
);


-- ============================================
-- Clients
-- ============================================

CREATE TABLE IF NOT EXISTS inventory_management_analytics.Clients (
    client_id TEXT,
    site_id TEXT,
    client_size TEXT,
    base_headcount INTEGER,
    weekend_pattern TEXT,
    is_24x7 BOOLEAN
);

-- ============================================
-- Restock
-- ============================================

CREATE TABLE IF NOT EXISTS inventory_management_analytics.Restock (
    restock_id TEXT,
    site_id TEXT,
    item_id TEXT,
    date DATE,
    qty INTEGER,
    restock_type TEXT
);

-- ============================================
-- Daily Usage
-- ============================================

CREATE TABLE IF NOT EXISTS inventory_management_analytics.Daily_usage (
    date DATE,
    site_id TEXT,
    client_id TEXT,
    item_id TEXT,
    day_type TEXT,
    effective_headcount INTEGER,
    shift TEXT,
    qty_drawn INTEGER,
    is_outlier BOOLEAN
);

-- Replace /your/file/path/ with the absolute path to your cleaned_data folder

COPY  inventory_management_analytics.Sites
FROM '/your/file/path/sites.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'utf8');

COPY  inventory_management_analytics.Items
FROM '/your/file/path/items.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'utf8');

COPY  inventory_management_analytics.Clients
FROM '/your/file/path/client.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'utf8');

COPY  inventory_management_analytics.Restock
FROM '/your/file/path/restock.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'utf8');

COPY  inventory_management_analytics.Daily_usage
FROM '/your/file/path/daily_usage.csv'
WITH (FORMAT csv, HEADER true, ENCODING 'utf8');

