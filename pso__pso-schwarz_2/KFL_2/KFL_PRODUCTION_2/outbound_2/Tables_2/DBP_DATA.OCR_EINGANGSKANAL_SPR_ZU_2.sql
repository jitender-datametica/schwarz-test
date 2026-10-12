CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ocr_eingangskanal_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ocr_eingangskanal_id STRING(1) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
ocr_eingangskanal_bez STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);