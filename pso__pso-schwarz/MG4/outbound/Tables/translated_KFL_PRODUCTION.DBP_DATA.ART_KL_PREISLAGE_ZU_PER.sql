DROP TABLE IF EXISTS kfl_production_dbp_data.art_kl_preislage_zu_per;
CREATE OR REPLACE TABLE kfl_production_dbp_data.art_kl_preislage_zu_per (
mandant_id INTEGER NOT NULL,
art_matching_id INTEGER NOT NULL,
kjmo INTEGER NOT NULL,
kjwo_update INTEGER DEFAULT 999912 NOT NULL,
wrg_id STRING(12) COLLATE 'und:ci',
sm_id STRING(40) COLLATE 'und:ci',
ksm_id STRING(16) COLLATE 'und:ci',
owg_id INTEGER,
wg_id INTEGER,
wug_id INTEGER,
vk_brutto_pk_1 NUMERIC(9,3),
durchschnitt_preis_kasse NUMERIC(18,4),
umsatz_brutto NUMERIC(18,4),
umsatz_brutto_af NUMERIC(18,4),
umsatz_brutto_sa NUMERIC(18,4),
menge NUMERIC(18,3),
menge_af NUMERIC(18,3),
menge_sa NUMERIC(18,3),
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY mandant_id, kjwo_update, kjmo;