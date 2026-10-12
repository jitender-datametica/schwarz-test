--==============================================================
-- Table: flw_absagegrund_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_absagegrund_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flw_absagegrund_spr_zu_1 (
absagegrund_id STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID des Absagegrunds für Kundenaufträge. Quelle ist das Feld abgru'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH. In der Regel länderbezogen'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der DWH-Sprache, z.B. 22 ist deutsch'),
absagegrund_bez STRING(40) COLLATE 'und:ci' NOT NULL OPTIONS(description='Bezeichnung des Absagegrundes aus bezei'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='FLW - Sprachabhängige Bezeichnung der Absagegründe aus der Tabelle tvagt');