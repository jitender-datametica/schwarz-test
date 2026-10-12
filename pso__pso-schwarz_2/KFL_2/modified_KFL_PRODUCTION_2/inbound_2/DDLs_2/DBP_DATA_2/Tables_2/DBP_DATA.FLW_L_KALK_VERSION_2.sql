--==============================================================
-- Table: flw_l_kalk_version_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalk_version_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_KALK_VERSION_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   kalk_version_id                     INTEGER     NOT NULL COMMENT 'Kalkulationsversion aus tvers',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_KALK_VERSION PRIMARY KEY (mandant_id, kalk_version_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup zur Version der Kalkulation - SAP P21 TCK32T';

