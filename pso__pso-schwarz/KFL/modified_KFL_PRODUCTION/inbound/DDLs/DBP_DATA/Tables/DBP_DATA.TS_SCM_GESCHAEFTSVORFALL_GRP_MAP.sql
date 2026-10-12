--==============================================================
-- Table: ts_scm_geschaeftsvorfall_grp_map
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_geschaeftsvorfall_grp_map
   generated from Powerdesigner on Dienstag, 13. Dezember 2022 12:58:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.TS_SCM_GESCHAEFTSVORFALL_GRP_MAP (
   geschaeftsvorfall_id                VARCHAR(4)      NOT NULL COMMENT 'Eindeutige ID eines Geschaeftsvorfalls aus gv_id, z.Bsp. 01',
   ewm_fg                              INTEGER    NOT NULL COMMENT 'Flag: EWM',
   scm_gv_grp_id                       VARCHAR(4)      NOT NULL COMMENT 'SCM Geschaeftsvorfallgruppe',
   scm_gv_prozess_id                   VARCHAR(4)      DEFAULT '-1' COMMENT 'SCM Geschäftsvorfallprozess',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_SCM_GESCHAEFTSVORFALL_GRP_MAP PRIMARY KEY (geschaeftsvorfall_id, ewm_fg, scm_gv_grp_id) NOT ENFORCED
)  COMMENT = 'Mapping SCM Geschaeftsvorfallgruppe';
