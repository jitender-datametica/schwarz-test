--==============================================================
-- Table: ts_scm_geschaeftsvorfall_prozess_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_geschaeftsvorfall_prozess_spr_zu
   generated from Powerdesigner on Dienstag, 13. Dezember 2022 13:01:54
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_geschaeftsvorfall_prozess_spr_zu (
scm_gv_prozess_id STRING(4) NOT NULL OPTIONS(description='SCM Geschäftsvorfallprozess'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprach-ID'),
scm_gv_grp_bez STRING(255) OPTIONS(description='SCM Geschaeftsvorfallgruppe Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (spr_id, scm_gv_prozess_id) NOT ENFORCED
) OPTIONS(description='SCM Geschäftsvorfallprozess translations');