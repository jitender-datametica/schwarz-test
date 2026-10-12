CREATE TABLE IF NOT EXISTS kfl_production_dbp_rfi.d_tankkunden (
marktnummer STRING(4) COLLATE 'und:ci',
wg_text STRING(40) COLLATE 'und:ci',
schluessel2 STRING(20) COLLATE 'und:ci',
wert STRING(9) COLLATE 'und:ci',
datum STRING(10) COLLATE 'und:ci',
cycle_id BIGNUMERIC(38,0),
loop_id BIGNUMERIC(38,0),
rfi_fehlergrund STRING(2000) COLLATE 'und:ci',
rfi_freigabe STRING(1) COLLATE 'und:ci',
rfi_datum DATE
);