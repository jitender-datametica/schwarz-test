--==============================================================
-- Table: in_leistungsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_leistungsart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_LEISTUNGSART_SPR_ZU_1 (
   co_leistungsart_id                  VARCHAR(7)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der CO-Leistungsart aus der Quelle lstar',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 ist deutsch',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   co_leistungsart_bez_kurz            VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Kurzbezeichnung der CO-Leistungsart aus ktext',
   co_leistungsart_bez_lang            VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Langbezeichnung der CO-Leistungsart aus ltext',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_LEISTUNGSART_SPR_ZU PRIMARY KEY (co_leistungsart_id, spr_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen  der CO-Leistungsarten aus SAP Industrie cslt';
