--==============================================================
-- Table: flw_herkunft_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_herkunft_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_HERKUNFT_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   herkunft_id                         NUMBER(38,0)     NOT NULL COMMENT 'ID der Herkunft',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der Sprache',
   herkunft_bez                        VARCHAR(40)      NOT NULL COMMENT 'Bezichnung der Herkunft',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_HERKUNFT_SPR_ZU PRIMARY KEY (mandant_id, herkunft_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprach-Tabelle für die Herkunft - SAP P21 -/SPMEAT/ORIGIN';

