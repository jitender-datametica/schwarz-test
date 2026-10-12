CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.handling_unit_ewm_qual_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_guid STRING(32) NOT NULL,
seq_nr BIGNUMERIC(38,0) NOT NULL,
pruef_art STRING(1) COLLATE 'und:ci',
lagernummer_id STRING(4) COLLATE 'und:ci',
datzeit_ausfuehrung TIMESTAMP,
handling_unit_id STRING(20) COLLATE 'und:ci',
lagersortiment_id STRING(1) COLLATE 'und:ci',
verschachtelt_fg BIGNUMERIC(38,0),
waqfk_status STRING(1) COLLATE 'und:ci',
gewicht_soll NUMERIC(15,3),
gewicht_ist NUMERIC(15,3),
menge_einh_id STRING(3) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);