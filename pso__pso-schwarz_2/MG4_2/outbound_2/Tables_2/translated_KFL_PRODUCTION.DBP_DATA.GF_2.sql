CREATE OR REPLACE TABLE kfl_production_dbp_data.gf_2 (
gf_id INTEGER NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant_2 im DWH'),
ek_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Kennzeichnet, ob es sich um einen dem Einkauf zugehörigen Mitarbeiter handelt'),
gf_name STRING(160) COLLATE 'und:ci' OPTIONS(description='Name des Geschäftsführers'),
td_update TIMESTAMP,
td_insert TIMESTAMP
) OPTIONS(description='VIS - Lookup Tabelle  Geschäftsführer');