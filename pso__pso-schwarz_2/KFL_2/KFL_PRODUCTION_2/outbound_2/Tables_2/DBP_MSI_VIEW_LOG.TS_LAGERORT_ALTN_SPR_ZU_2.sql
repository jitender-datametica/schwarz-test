CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_view_log.ts_lagerort_altn_spr_zu_2 (
mandant_id INTEGER NOT NULL,
lagerort_id STRING NOT NULL,
wup_id INTEGER NOT NULL,
nb_id INTEGER NOT NULL,
spr_id INTEGER NOT NULL,
lagerort_bez STRING(20) DEFAULT ' ' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);