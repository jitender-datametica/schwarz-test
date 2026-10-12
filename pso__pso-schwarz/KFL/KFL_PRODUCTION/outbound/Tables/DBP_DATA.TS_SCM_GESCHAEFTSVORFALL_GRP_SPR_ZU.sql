--==============================================================
-- Table: ts_scm_geschaeftsvorfall_grp_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_geschaeftsvorfall_grp_spr_zu
   generated from Powerdesigner on Monday, May 30, 2022 9:54:44 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_geschaeftsvorfall_grp_spr_zu (
scm_gv_grp_id STRING(4) NOT NULL OPTIONS(description='SCM Geschaeftsvorfallgruppe'),
spr_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Sprach-ID'),
scm_gv_grp_bez STRING(255) OPTIONS(description='SCM Geschaeftsvorfallgruppe Bezeichnung'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (scm_gv_grp_id, spr_id) NOT ENFORCED
) OPTIONS(description='SCM Geschaeftsvorfallgruppe');