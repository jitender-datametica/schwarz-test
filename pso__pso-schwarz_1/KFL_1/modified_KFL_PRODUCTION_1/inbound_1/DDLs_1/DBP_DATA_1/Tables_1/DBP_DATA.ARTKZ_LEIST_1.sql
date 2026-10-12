--==============================================================
-- Table: artkz_leist_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_leist_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_LEIST_1 (
   leist_id                            VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Artikelkennzeichen Leistungsstark Food',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   leist_bez                           VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Leistungsstärke Food Bezeichnung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_LEIST PRIMARY KEY (leist_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle des Artikelkennzeichens leistungsstark';

