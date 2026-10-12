--==============================================================
-- Table: ts_scm_geschaeftsvorfall_prozess_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_geschaeftsvorfall_prozess_spr_zu_1
   generated from Powerdesigner on Dienstag, 13. Dezember 2022 13:01:54
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_SCM_GESCHAEFTSVORFALL_PROZESS_SPR_ZU_1 (
   scm_gv_prozess_id                   VARCHAR(4)      NOT NULL COMMENT 'SCM Geschäftsvorfallprozess',
   spr_id                              INTEGER    NOT NULL COMMENT 'Sprach-ID',
   scm_gv_grp_bez                      VARCHAR(255)    COMMENT 'SCM Geschaeftsvorfallgruppe Bezeichnung',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_SCM_GESCHAEFTSVORFALL_PROZESS_SPR_ZU PRIMARY KEY (spr_id, scm_gv_prozess_id) NOT ENFORCED
)  COMMENT = 'SCM Geschäftsvorfallprozess translations';
