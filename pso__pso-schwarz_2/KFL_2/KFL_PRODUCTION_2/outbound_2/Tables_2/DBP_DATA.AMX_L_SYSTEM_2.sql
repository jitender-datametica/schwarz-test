--==============================================================
-- Table: amx_l_system_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_l_system_2
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.amx_l_system_2 (
amx_system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Amx System ID zur unterscheidung der verschiedenen AMX Systeme'),
amx_system_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung der unterschiedlichen AMX Systeme'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id) NOT ENFORCED
) OPTIONS(description='Lookup Tabelle für die unterschiedlichen AMX Quellsysteme.             ');