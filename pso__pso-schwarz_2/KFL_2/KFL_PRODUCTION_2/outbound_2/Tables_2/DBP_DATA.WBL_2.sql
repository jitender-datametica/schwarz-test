CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.wbl_2 (
wbl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warenbereichsleiter ID'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
wbl_dat_von DATE OPTIONS(description='Gültig-ab Datum des Warenbereichsleiters'),
wbl_name STRING(160) COLLATE 'und:ci' OPTIONS(description='Name des Warenbereichsleiters'),
gf_id BIGNUMERIC(38,0) OPTIONS(description='Geschäftsführer ID'),
ek_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Warenbereichsleiter ');