CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.aktivitaetsbereich_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH'),
lagernummer_id STRING(4) NOT NULL OPTIONS(description='Lagernummer'),
aktivitaetsbereich_id STRING(4) NOT NULL OPTIONS(description='Aktivitätsbereich'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
aktivitaetsbereich_bez STRING(40) OPTIONS(description='Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='Aktivitätsbereich - Bezeichnung');