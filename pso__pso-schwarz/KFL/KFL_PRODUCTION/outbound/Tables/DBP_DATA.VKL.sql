CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vkl (
vkl_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Verkaufsleiters'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
gf_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Geschäftsführer ID, numerisch'),
vkl_name STRING(320) OPTIONS(description='Name des Verkaufsleiters'),
td_insert TIMESTAMP,
td_update TIMESTAMP
) OPTIONS(description='VIS - Lookup Tabelle Verkaufsleiter');