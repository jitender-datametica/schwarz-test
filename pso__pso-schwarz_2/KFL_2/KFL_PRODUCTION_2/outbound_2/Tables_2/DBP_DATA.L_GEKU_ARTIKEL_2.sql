CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_geku_artikel_2 (
geku_artikel_uid INTEGER NOT NULL,
geku_artikel_id STRING(60) COLLATE 'und:ci' NOT NULL,
geku_grund_uid INTEGER NOT NULL,
land_iso STRING(2) COLLATE 'und:ci' NOT NULL,
geku_dwh_artikel_id BIGNUMERIC(38,0),
aktiv_fg BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
alt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);