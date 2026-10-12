CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_handling_unit (
mandant_id BIGNUMERIC(38,0) NOT NULL,
handling_unit_id INTEGER NOT NULL,
flw_kunde_id BIGNUMERIC(38,0),
handling_unit_id_ext STRING(20) COLLATE 'und:ci' NOT NULL,
ntvol_ladung NUMERIC(18,3),
brtvol_ladung NUMERIC(18,3),
ntgew_ladung NUMERIC(18,3),
brtgew_ladung NUMERIC(18,3),
hu_voleinh_id STRING(3) COLLATE 'und:ci',
hu_geweinh_id STRING(3) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);