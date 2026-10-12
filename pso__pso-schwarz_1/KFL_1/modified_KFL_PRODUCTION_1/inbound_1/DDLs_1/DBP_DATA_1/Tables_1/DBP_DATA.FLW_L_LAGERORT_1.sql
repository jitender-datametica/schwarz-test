--==============================================================
-- Table: flw_l_lagerort_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_lagerort_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_LAGERORT_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_LAGERORT PRIMARY KEY (mandant_id, werk_id, lagerort_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Lagerorte aus SAP Industrie t001_1';

