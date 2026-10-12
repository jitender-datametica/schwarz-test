--==============================================================
-- Table: achsgruppe_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: achsgruppe_spr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:36 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ACHSGRUPPE_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   achsgruppe_id                       NUMBER(38,0)     NOT NULL COMMENT 'Gruppierung von Regalachsen aus achsgrid',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprachschlüssel im DWH',
   achsgruppe_bez                      VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Achsgruppe aus achsgrt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ACHSGRUPPE_SPR_ZU PRIMARY KEY (mandant_id, achsgruppe_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - WPL - WaSA Achsgruppen Bezeichnungen';

