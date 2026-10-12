CREATE OR REPLACE TABLE kfl_production_dbp_data.amx_l_system_1 (
amx_system_id INTEGER NOT NULL OPTIONS(description='Amx System ID zur unterscheidung der verschiedenen AMX Systeme'),
amx_system_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der unterschiedlichen AMX Systeme'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id) NOT ENFORCED
) OPTIONS(description='Lookup Tabelle für die unterschiedlichen AMX Quellsysteme.\n             ');