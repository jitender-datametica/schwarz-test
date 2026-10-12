CREATE OR REPLACE TABLE kfl_production_dbp_data.vkl (
vkl_id INTEGER NOT NULL OPTIONS(description='ID des Verkaufsleiters'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH'),
gf_id INTEGER NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
vkl_name STRING(320) OPTIONS(description='Name des Verkaufsleiters'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='VIS - Lookup Tabelle Verkaufsleiter');