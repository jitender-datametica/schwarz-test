--==============================================================
-- Table: l_listungsstufe
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_listungsstufe
   generated from Powerdesigner on Montag, 26. Februar 2024 17:46:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_listungsstufe (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant im DWH'),
listungsstufe_kz STRING(50) NOT NULL OPTIONS(description='Kennzeichen der Listungsstufe.'),
listungsstufe_bez STRING(200) NOT NULL OPTIONS(description='Bezeichnung der Listungsstufe.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, listungsstufe_kz) NOT ENFORCED
)
OPTIONS(description='Tabelle für verschiedene Listungsstufen. Eine Listungsstufe ist eine Eingruppierung jedes einzelnen Artikels.');