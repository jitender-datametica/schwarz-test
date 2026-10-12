--==============================================================
-- Table: flag_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flag_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.flag_spr_zu_1 (
flag BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag-Ausprägung. Kann 0 oder 1 sein'),
flag_typ_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flagtyp. 1 steht für ja/nein'),
spr_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.'),
flag_bez STRING(50) COLLATE 'und:ci' NOT NULL
OPTIONS(description='Bezeichnung des Flags. Bei flag=1,flag_typ_id=1 und spr_id=22 ist die Bezeichnung ja'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (flag, flag_typ_id, spr_id) NOT ENFORCED
) OPTIONS(description='GEKU - universell einsetzbare Tabelle zur Zuweisung von Texten zu Flags');