--==============================================================
-- Table: flw_kalk_version_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_version_spr_zu
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_VERSION_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kalk_version_id                     INTEGER     NOT NULL COMMENT 'Kalkulationsversion aus tvers',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   kalk_version_bez                    VARCHAR(30)      NOT NULL DEFAULT ' ' COMMENT 'Bezeichnung der Kalkulationsversion',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_VERSION_SPR_ZU PRIMARY KEY (mandant_id, kalk_version_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Kalkulationsversion - SAP P21 TCK32T';

