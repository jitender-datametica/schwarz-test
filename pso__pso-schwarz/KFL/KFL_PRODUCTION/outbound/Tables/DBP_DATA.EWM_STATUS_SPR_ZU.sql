CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ewm_status_spr_zu (
status_id STRING(5) NOT NULL OPTIONS(description='Status ID'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache'),
status_schema_id STRING(8) NOT NULL OPTIONS(description='Statusschema'),
status_kbez STRING(4) OPTIONS(description='Statustext (kurz)'),
status_bez STRING(30) OPTIONS(description='Statustext (lang)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration')
) OPTIONS(description='EWM Status');