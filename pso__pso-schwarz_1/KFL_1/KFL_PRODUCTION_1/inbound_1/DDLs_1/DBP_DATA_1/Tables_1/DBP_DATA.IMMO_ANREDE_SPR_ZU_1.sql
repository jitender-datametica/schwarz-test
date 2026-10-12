--==============================================================
-- Table: immo_anrede_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_anrede_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_ANREDE_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   anrede_id                           VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID Anrede Partner',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   anrede_bez                          VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Anrede Partner',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_ANREDE_SPR_ZU PRIMARY KEY (mandant_id, anrede_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Tabelle für die Anrede - SAP REFX - TSAD3T';
