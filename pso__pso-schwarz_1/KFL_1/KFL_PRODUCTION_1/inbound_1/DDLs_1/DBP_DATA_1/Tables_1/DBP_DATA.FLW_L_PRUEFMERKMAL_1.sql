--==============================================================
-- Table: flw_l_pruefmerkmal_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_pruefmerkmal_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:42 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_PRUEFMERKMAL_1 (
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   stp_merkmal_id                      NUMBER(38,0)     NOT NULL COMMENT 'Stammprüfmerkmal aus mkmnr',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_PRUEFMERKMAL PRIMARY KEY (werk_id, stp_merkmal_id, mandant_id, system_id) NOT ENFORCED
)  COMMENT = 'FLW - Prüfmerkmalsstamm aus qpmk';

