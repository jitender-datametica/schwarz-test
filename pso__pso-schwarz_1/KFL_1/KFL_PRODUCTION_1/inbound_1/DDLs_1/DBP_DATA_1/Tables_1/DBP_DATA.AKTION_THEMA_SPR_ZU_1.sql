--==============================================================
-- Table: aktion_thema_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: aktion_thema_spr_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AKTION_THEMA_SPR_ZU_1 (
   aktion_thema_id                     VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Aktionsthema aus der SAP Tabelle WAKP_1',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Sprache im DWH',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   aktion_thema_bez                    VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung für das Aktionsthema',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AKTION_THEMA_SPR_ZU PRIMARY KEY (aktion_thema_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Bezeichnung der Aktionsthemen';

