--==============================================================
-- Table: arthiertyp_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: arthiertyp_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTHIERTYP_2 (
   arthiertyp_id                       NUMBER(38,0)     NOT NULL COMMENT 'Artikel_2 - Hierarchie - Typ - ID: kennzeichnet z.Bsp., ob es sich um eine_2 Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt',
   arthiertyp_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Artikelhierarchie',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTHIERTYP PRIMARY KEY (arthiertyp_id) NOT ENFORCED
)  COMMENT = 'Typen der Artikelhierarchie - kennzeichnet zur Zeit_2 die zwei- oder dreistellige Warengruppenhierarchie';

