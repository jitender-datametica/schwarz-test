--==============================================================
-- Table: in_instandhaltung_leistungsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_instandhaltung_leistungsart_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_INSTANDHALTUNG_LEISTUNGSART_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   instandhaltung_leistungsart_id      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Instandhaltungs-Leistungsart aus dem Quellfeld ilart',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   instandhaltung_leistungsart_bez     VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_INSTANDHALTUNG_LEISTUNGSART_SPR_ZU PRIMARY KEY (mandant_id, instandhaltung_leistungsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachtabelle Leistungsarten der Instandhaltung';
