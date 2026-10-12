--==============================================================
-- Table: ts_scm_geschaeftsvorfall_grp_map
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_scm_geschaeftsvorfall_grp_map
   generated from Powerdesigner on Dienstag, 13. Dezember 2022 12:58:47
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.ts_scm_geschaeftsvorfall_grp_map (
geschaeftsvorfall_id STRING(4) NOT NULL
OPTIONS(description='Eindeutige ID eines Geschaeftsvorfalls aus gv_id, z.Bsp. 01'),
ewm_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Flag: EWM'),
scm_gv_grp_id STRING(4) NOT NULL OPTIONS(description='SCM Geschaeftsvorfallgruppe'),
scm_gv_prozess_id STRING(4) DEFAULT '-1' OPTIONS(description='SCM Geschäftsvorfallprozess'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (geschaeftsvorfall_id, ewm_fg, scm_gv_grp_id) NOT ENFORCED
) OPTIONS(description='Mapping SCM Geschaeftsvorfallgruppe');