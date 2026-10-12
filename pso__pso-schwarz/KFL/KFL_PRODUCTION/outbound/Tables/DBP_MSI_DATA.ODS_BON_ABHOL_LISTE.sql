CREATE TABLE IF NOT EXISTS kfl_production_dbp_msi_data.ods_bon_abhol_liste (
bon_id STRING(25) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
zeitstempel_druck DATETIME NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id, wup_id;