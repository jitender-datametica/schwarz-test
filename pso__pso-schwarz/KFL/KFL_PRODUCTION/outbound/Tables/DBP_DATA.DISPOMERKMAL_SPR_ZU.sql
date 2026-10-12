--==============================================================
-- Table: dispomerkmal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dispomerkmal_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.dispomerkmal_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
dispomerkmal STRING(2) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.'),
dispomerkmal_bez STRING(40) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Sprachabhängige Bezeichnung des Dispomerkmals'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
) OPTIONS(description='TP408_LVS- Sprachabhängige Bezeichnungen des Dispomerkmals');