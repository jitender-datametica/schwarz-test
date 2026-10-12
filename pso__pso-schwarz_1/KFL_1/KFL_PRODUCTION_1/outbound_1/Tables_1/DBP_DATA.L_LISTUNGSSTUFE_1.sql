--==============================================================
-- Table: l_listungsstufe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_listungsstufe_1
   generated from Powerdesigner on Montag, 26. Februar 2024 17:46:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_listungsstufe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
listungsstufe_kz STRING(50) NOT NULL OPTIONS(description='Kennzeichen der Listungsstufe.'),
listungsstufe_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung der Listungsstufe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, listungsstufe_kz) NOT ENFORCED
)
OPTIONS(description='Tabelle für verschiedene Listungsstufen. Eine_1 Listungsstufe ist eine_1 Eingruppierung jedes einzelnen Artikels.');