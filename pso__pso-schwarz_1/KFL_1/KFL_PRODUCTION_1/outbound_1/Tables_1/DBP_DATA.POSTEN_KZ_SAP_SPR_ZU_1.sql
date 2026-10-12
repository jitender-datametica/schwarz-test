CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.posten_kz_sap_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
posten_kz_sap STRING(2) COLLATE 'und:ci' NOT NULL,
posten_bez_sap STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);