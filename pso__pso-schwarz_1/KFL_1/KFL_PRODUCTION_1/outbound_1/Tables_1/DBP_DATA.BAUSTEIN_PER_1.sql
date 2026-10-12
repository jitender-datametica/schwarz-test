--==============================================================
-- Table: baustein_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.baustein_per_1 (
baustein_id INTEGER NOT NULL OPTIONS(description='ID eines Sortimentsbausteins'),
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprache im DWH'),
baustein_bez STRING(40) COLLATE 'und:ci' OPTIONS(description='Bezeichnung eines Sortimentsbausteins'),
dat_von DATE OPTIONS(description='Beginn des Gültigeitsbereichs'),
dat_bis DATE OPTIONS(description='Ende des Gültigkeitsbereichs'),
baustein_art_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Sortiment Bausteinart (WSOH.STYPB) z.B. 1=Normalbautein, 2=Aktionsbaustein, etc.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (baustein_id, mandant_id) NOT ENFORCED
) OPTIONS(description='TP2/7 AIS - Stammdatentabelle der Bausteine (Sortimentsbaustein) - MULTISET');