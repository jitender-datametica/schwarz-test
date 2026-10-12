DROP TABLE IF EXISTS kfl_production_dbp_msi_data.nl_listung_kmo_20200414_171500_1;
--In BigQuery, primary key columns cannot have collation.Removing the primary key constraint and applying NOT NULL instead, since in BQ, primary keys are not enforced.
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.nl_listung_kmo_20200414_171500_1 (
mandant_id INTEGER NOT NULL,
listung_art STRING(400) COLLATE 'und:ci' NOT NULL,
sm_id_selected INTEGER NOT NULL,
sm_id INTEGER NOT NULL,
gtin STRING(1200) COLLATE 'und:ci' NOT NULL,
ost_basis STRING(4) COLLATE 'und:ci' NOT NULL,
ost_gross STRING(4) COLLATE 'und:ci' NOT NULL,
sued_ost STRING(4) COLLATE 'und:ci' NOT NULL,
sued_west STRING(4) COLLATE 'und:ci' NOT NULL,
west STRING(4) COLLATE 'und:ci' NOT NULL,
nord STRING(4) COLLATE 'und:ci' NOT NULL,
kl_owg_id INTEGER,
wg_id INTEGER NOT NULL,
art_nielsen_bez STRING(1020) COLLATE 'und:ci',
umsatz_artikel NUMERIC(29,4),
durchschnitt_anz_maerkte INTEGER,
durchschnitt_preis NUMERIC(29,4),
anz_wochen INTEGER,
anz_maerkte INTEGER,
umsatz_hr NUMERIC(29,4),
absatz_hr NUMERIC(29,4),
kjwo_update INTEGER,
td_update TIMESTAMP,
td_insert TIMESTAMP
) CLUSTER BY kjwo_update, sm_id_selected;