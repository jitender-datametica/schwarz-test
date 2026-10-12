--==============================================================
-- Table: flag_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flag_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLAG_SPR_ZU_2 (
   flag                                INTEGER     NOT NULL COMMENT 'Flag-Ausprägung. Kann 0 oder 1 sein',
   flag_typ_id                         INTEGER     NOT NULL COMMENT 'Flagtyp. 1 steht für ja/nein',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_2 referenziert.',
   flag_bez                            VARCHAR(50)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Flags. Bei flag=1,flag_typ_id=1 und spr_id=22 ist die Bezeichnung ja',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLAG_SPR_ZU PRIMARY KEY (flag, flag_typ_id, spr_id) NOT ENFORCED
)  COMMENT = 'GEKU - universell einsetzbare Tabelle zur Zuweisung von Texten zu Flags';

