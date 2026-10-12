CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_posten_kz_sap_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
posten_kz_sap STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);