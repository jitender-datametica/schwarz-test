--==============================================================
-- Table: flw_l_codegruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_codegruppe_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_l_codegruppe_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
katalogart_id STRING(1) COLLATE 'und:ci' NOT NULL OPTIONS(description='Katalogart'),
codegruppe_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID der codegruppe'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Lookup-Tabelle der Codegruppen aus qpgr');