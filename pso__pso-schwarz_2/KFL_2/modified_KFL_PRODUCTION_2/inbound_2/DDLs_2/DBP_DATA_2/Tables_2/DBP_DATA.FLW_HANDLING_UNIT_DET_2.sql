--==============================================================
-- Table: flw_handling_unit_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_handling_unit_det_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:39 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_HANDLING_UNIT_DET_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   handling_unit_id                    INTEGER     NOT NULL COMMENT 'Interne Handling Unit_2 Nummer aus Feld VENUM',
   handling_unit_pos_id                INTEGER     NOT NULL COMMENT 'Handling Unit_2 Position aus Feld VEPOS',
   anz_verk_menge_einh                 INTEGER     COMMENT 'Anzahl Packhilfsmittel (Verkaufsmengeneinheit) in der HU-Position aus Feld VEANZ',
   verk_menge_einh_id                  VARCHAR(3)       COLLATE 'en-ci' COMMENT 'Verkaufsmengeneinheit aus Feld ZZVRKME',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_HANDLING_UNIT_DET PRIMARY KEY (mandant_id, handling_unit_id, handling_unit_pos_id) NOT ENFORCED
)  COMMENT = 'FLW - Verpacken: Handling Unit_2 Position (Inhalt) - SAP FLW (P21) - VEPO';

