--==============================================================
-- Table: belos_vorgangart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_vorgangart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:14 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.belos_vorgangart_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).'),
belos_vorgangart_id STRING(10) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Kennzeichen für die Art_1 des Belos Vorgangs (z. B. Beschaffung, Annahmeverweigerung)'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
belos_vorgangart_bez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Bezeichnung für die Arten des Belos Vorgangs.'),
belos_vorgangart_kbez STRING(40) COLLATE 'und:ci'
OPTIONS(description='Sprachabhängige Kurzbezeichnung für die Arten des Belos Vorgangs.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, spr_id) NOT ENFORCED
)
OPTIONS(description='LIS - Spachabhaengige Kurzbezeichnungen fuer die Schluessel der Lookuptaballe l_belos_vorgangart.');