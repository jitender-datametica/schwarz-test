--==============================================================
-- Table: baustein_per_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: baustein_per_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BAUSTEIN_PER_1 (
   baustein_id                         NUMBER(18,0)     NOT NULL COMMENT 'ID eines Sortimentsbausteins',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   baustein_bez                        VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung eines Sortimentsbausteins',
   dat_von                             DATE             COMMENT 'Beginn des Gültigeitsbereichs',
   dat_bis                             DATE             COMMENT 'Ende des Gültigkeitsbereichs',
   baustein_art_id                     NUMBER(38,0)     NOT NULL DEFAULT -1 COMMENT 'Sortiment Bausteinart (WSOH.STYPB) z.B. 1=Normalbautein, 2=Aktionsbaustein, etc.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BAUSTEIN_PER PRIMARY KEY (baustein_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2/7 AIS - Stammdatentabelle der Bausteine (Sortimentsbaustein) - MULTISET';

