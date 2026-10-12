--==============================================================
-- Table: flw_hauptgruppe_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_hauptgruppe_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_hauptgruppe_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_2 im DWH. In der Regel länderbezogen'),
hauptgruppe_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Hauptgruppe = oberste Hierarchiestufe der Fleischwerk- Produkthierarchie. Entspricht der Tierart'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Hauptgruppe aus  zfw_hauptgr');