--==============================================================
-- Table: flw_lagerort_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_lagerort_spr_zu_2
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_LAGERORT_SPR_ZU_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   werk_id                             NUMBER(38,0)     NOT NULL COMMENT 'Numerischer Surrogate key für das Werk werks',
   lagerort_id                         VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel für die Lagerorte',
   spr_id                              NUMBER(38,0)     NOT NULL,
   lagerort_bez                        VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Lagerorts',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_LAGERORT_SPR_ZU PRIMARY KEY (mandant_id, werk_id, lagerort_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnungen der Lagerorte aus SAP Industrie t001_2';

