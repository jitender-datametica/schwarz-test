--==============================================================
-- Table: flw_lagerort_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerort_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LAGERORT_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   werk_id                             INTEGER     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte',
   spr_id                              INTEGER     NOT NULL,
   lagerort_bez                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Lagerorts',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LAGERORT_SPR_ZU PRIMARY KEY (mandant_id, werk_id, lagerort_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Lagerorte aus SAP Industrie t001';

