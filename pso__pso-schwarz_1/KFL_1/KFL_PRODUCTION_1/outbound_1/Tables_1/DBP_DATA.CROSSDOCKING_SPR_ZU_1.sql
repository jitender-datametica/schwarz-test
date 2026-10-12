--==============================================================
-- Table: crossdocking_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: crossdocking_spr_zu_1
   generated from Powerdesigner on Dienstag, 1. April 2025 17:51:39
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.crossdocking_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH.'),
crossdocking_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID des Umschlagplatzs bzw. Cross Docking Orts.'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='ID der Sprache. Referenz zu der Tabelle spr.'),
crossdocking_bez STRING(200) NOT NULL
OPTIONS(description='Sprachabhängig Kurzbezeichnung des Umschlagplatzs bzw. Cross-Docking-Orts. Bsp "Wien Plattform" -  Lieferanten im Frische Bereich liefert an die Wien Plattform. Diese verteilt die Lieferung auf die Länder (VZ/Märkte). Weitere Cross Docking Orte sind noch nicht bekannt.(Stand: 24.03.2025)'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, crossdocking_id, spr_id) NOT ENFORCED
) OPTIONS(description='Sprachabhängige Bezeichnungen des Cross Docking Orts.');