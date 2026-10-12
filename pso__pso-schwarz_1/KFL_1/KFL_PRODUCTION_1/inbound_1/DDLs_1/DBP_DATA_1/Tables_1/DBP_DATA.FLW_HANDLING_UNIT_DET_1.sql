--==============================================================
-- Table: flw_handling_unit_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_handling_unit_det_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_HANDLING_UNIT_DET_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   handling_unit_id                    NUMBER(18,0)     NOT NULL COMMENT 'Interne Handling Unit_1 Nummer aus Feld VENUM',
   handling_unit_pos_id                NUMBER(38,0)     NOT NULL COMMENT 'Handling Unit_1 Position aus Feld VEPOS',
   anz_verk_menge_einh                 NUMBER(38,0)     COMMENT 'Anzahl Packhilfsmittel (Verkaufsmengeneinheit) in der HU-Position aus Feld VEANZ',
   verk_menge_einh_id                  VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Verkaufsmengeneinheit aus Feld ZZVRKME',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_HANDLING_UNIT_DET PRIMARY KEY (mandant_id, handling_unit_id, handling_unit_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Verpacken: Handling Unit_1 Position (Inhalt) - SAP FLW (P21) - VEPO';

