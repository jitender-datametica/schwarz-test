CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.gf (
gf_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
ek_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt'),
gf_name STRING(160) COLLATE 'und:ci' OPTIONS(description='Name des Geschäftsführers'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Lookup Tabelle  Geschäftsführer');