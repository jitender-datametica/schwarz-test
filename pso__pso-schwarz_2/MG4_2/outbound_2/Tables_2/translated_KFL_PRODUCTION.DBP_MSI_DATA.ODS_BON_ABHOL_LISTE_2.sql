DROP TABLE IF EXISTS kfl_production_dbp_msi_data.ods_bon_abhol_liste_2;
CREATE OR REPLACE TABLE kfl_production_dbp_msi_data.ods_bon_abhol_liste_2 (
bon_id STRING(25) NOT NULL,
mandant_id INTEGER NOT NULL,
wup_id INTEGER NOT NULL,
zeitstempel_druck DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, wup_id;