--==============================================================
-- Table: ts_scm_geschaeftsvorfall_grp_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_geschaeftsvorfall_grp_spr_zu_2
   generated from Powerdesigner on Monday, May 30, 2022 9:54:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_SCM_GESCHAEFTSVORFALL_GRP_SPR_ZU_2 (
   scm_gv_grp_id                       VARCHAR(4)      NOT NULL COMMENT 'SCM Geschaeftsvorfallgruppe',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprach-ID',
   scm_gv_grp_bez                      VARCHAR(255)    COMMENT 'SCM Geschaeftsvorfallgruppe Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_SCM_GESCHAEFTSVORFALL_GRP_SPR_ZU PRIMARY KEY (scm_gv_grp_id, spr_id) NOT ENFORCED
)  COMMENT = 'SCM Geschaeftsvorfallgruppe';
