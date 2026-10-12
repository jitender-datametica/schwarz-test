--==============================================================
-- Table: immo_besitzstatus_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_besitzstatus_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_BESITZSTATUS_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   besitzstatus_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Besitzstatus ',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   besitzstatus_bez                    VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung Besitzstatus',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_BESITZSTATUS_SPR_ZU PRIMARY KEY (mandant_id, besitzstatus_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Bezeichnungen des Besitzstatus der Wirtschaftseinheit - SAP REFX - ZRE_BESITZSTATT';
