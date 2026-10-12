--==============================================================
-- Table: flw_produktgruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_produktgruppe_spr_zu_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:43 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_produktgruppe_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
produktgruppe_id STRING(10) COLLATE 'und:ci' NOT NULL OPTIONS(description='Produktguppe Id aus prodgr'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Eindeutige ID für jede Sprache'),
system_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'),
produktgruppe_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Produktgruppen Bezeichnung aus bezeich'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Produktgruppen - Bezeichnungen aus zfw_prodgr');