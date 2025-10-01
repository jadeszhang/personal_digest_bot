

PRAGMA foreign_keys = ON;
--================================ Entities and Sites
CREATE TABLE IF NOT EXISTS entities_and_sites (
  id               INTEGER PRIMARY KEY,
  name             TEXT NOT NULL,
  domain           TEXT,
  provider         TEXT,
  website_url      TEXT,
  feed_url         TEXT,
  is_active        INTEGER NOT NULL DEFAULT 1,
  last_checked_at  TEXT,
  last_status      TEXT,
  notes            TEXT
);

CREATE INDEX IF NOT EXISTS idx_entities_and_sites_provider ON entities_and_sites(provider);

--================================= job posts 
CREATE TABLE IF NOT EXISTS posts (
  id            INTEGER PRIMARY KEY,
  entity_id     INTEGER,
  fingerprint   TEXT UNIQUE NOT NULL,
  title         TEXT NOT NULL,
  url           TEXT,
  location      TEXT,
  body          TEXT,
  posted_at     TEXT,
  first_seen_at TEXT NOT NULL DEFAULT (datetime('now')),
  last_seen_at  TEXT NOT NULL DEFAULT (datetime('now')),
  meta_json     TEXT,
  FOREIGN KEY (entity_id) REFERENCES entities_and_sites(id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_posts_fp ON posts(fingerprint);
CREATE INDEX IF NOT EXISTS idx_posts_entity ON posts(entity_id);
CREATE INDEX IF NOT EXISTS idx_posts_posted ON posts(posted_at);
CREATE INDEX IF NOT EXISTS idx_posts_last_seen ON posts(last_seen_at);

--==================================Staging table new job posts
CREATE TABLE IF NOT EXISTS new_posts (
  id            INTEGER PRIMARY KEY,
  entity_id    INTEGER,
  fingerprint   TEXT NOT NULL,
  title         TEXT NOT NULL,
  url           TEXT,
  location      TEXT,
  body          TEXT,
  posted_at     TEXT,
  ingested_at   TEXT NOT NULL DEFAULT (datetime('now')),
  meta_json     TEXT,
  FOREIGN KEY (entity_id) REFERENCES entities_and_sites(id) ON DELETE SET NULL
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_new_posts_fp ON new_posts(fingerprint);
