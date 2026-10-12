--==============================================================
-- Table: brand_abschnitt_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: brand_abschnitt_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.brand_abschnitt_spr_zu (
brand_abschnitt_id STRING(2) COLLATE 'und:ci' NOT NULL OPTIONS(description='ID des Brandabschnitts aus brand'),
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
lagernummer_id STRING(3) COLLATE 'und:ci' NOT NULL
OPTIONS(description='ID der Lagernummer - höchste Ebene der Lagerhierarchie'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
brand_abschnitt_bez STRING(20) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Brandabschnitts aus brant'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='LIS - Sprachabhängige Bezeichnungen der Brandabschnitte aus t309t');