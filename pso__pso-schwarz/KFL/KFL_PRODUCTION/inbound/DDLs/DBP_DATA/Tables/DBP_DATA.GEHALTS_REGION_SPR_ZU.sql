--==============================================================
-- Table: gehalts_region_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: gehalts_region_spr_zu
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.GEHALTS_REGION_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   gehalts_region_id                   VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Gehaltsregion aus region',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   gehalts_region_bez                  VARCHAR(20)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung der Gehaltsregion aus region_txt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_GEHALTS_REGION_SPR_ZU PRIMARY KEY (mandant_id, gehalts_region_id, spr_id) NOT ENFORCED
)  COMMENT = 'SHR - Sprachabhängige Bezeichnung der Gehaltsregionen aus zhrregion';

