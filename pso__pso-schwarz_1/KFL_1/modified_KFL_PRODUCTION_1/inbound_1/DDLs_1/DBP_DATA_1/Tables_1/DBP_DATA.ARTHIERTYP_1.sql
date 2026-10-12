--==============================================================
-- Table: arthiertyp_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: arthiertyp_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTHIERTYP_1 (
   arthiertyp_id                       INTEGER     NOT NULL COMMENT 'Artikel_1 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_1 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   arthiertyp_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Artikelhierarchie',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTHIERTYP PRIMARY KEY (arthiertyp_id) NOT ENFORCED
)  COMMENT = 'Typen der Artikelhierarchie - kennzeichnet zur Zeit_1 die zwei- oder dreistellige Warengruppenhierarchie';

