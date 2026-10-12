CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ginfo_flaeche_typ_1 (
ginfo_flaeche_typ_id STRING(50) COLLATE 'und:ci' NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
flaeche_quelle_id BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);