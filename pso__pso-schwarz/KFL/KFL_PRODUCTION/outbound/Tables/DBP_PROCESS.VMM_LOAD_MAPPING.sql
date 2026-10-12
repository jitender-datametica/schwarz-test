CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.vmm_load_mapping (
mandant_id BIGNUMERIC(38,0) NOT NULL,
material_id STRING(20) COLLATE 'und:ci' NOT NULL,
kostenart STRING(10) COLLATE 'und:ci' NOT NULL,
sachkonto_id BIGNUMERIC(38,0) NOT NULL,
aac_id STRING(10) COLLATE 'und:ci',
string_mietvertrag STRING(50) COLLATE 'und:ci',
flaeche_typ_id STRING(3) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);