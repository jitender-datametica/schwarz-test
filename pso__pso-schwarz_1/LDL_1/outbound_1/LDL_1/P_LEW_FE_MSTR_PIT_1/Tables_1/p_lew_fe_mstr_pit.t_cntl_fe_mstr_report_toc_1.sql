/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for CNTL_FE_MSTR_REPORT_TOC
#-------------------------------------------------------------------------------
# Describtion: Create DDL for FE MSTR Reporting Toc Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-30 Mike Davis      Checks, formatting
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA added COMMIT
#  2.0	2022-07-14 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 


SELECT get_ddl('table','P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC_1');


DROP TABLE IF EXISTS P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_REPORT_TOC_1

*/


-- Versioning
 -- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_report_toc_1 (
report_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Identifier, implicied logic'),
report_sort_val INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Sorting Order of the Frontend Reports'),
report_name STRING(16777216) DEFAULT 'N/A' NOT NULL OPTIONS(description='MicroStrategy Name of Reporting Object'),
report_guid STRING(16777216) DEFAULT '00000000000000000000000000000000' NOT NULL
OPTIONS(description='MicroStrategy GUID Identifier '),
report_annotation STRING(16777216) OPTIONS(description='Annotation of Frontend Report'),
report_visible_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / Indicator if Report is visible '),
report_teaser_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / Indicator if Report is a teaser Report'),
report_type_fg INTEGER DEFAULT 0 OPTIONS(description='Flag / Indicator if a Report is a RSD or Visual Insight Report'),
report_panel_name STRING(16777216) OPTIONS(description='Technical Field: MicroStrategy internal Panel Name'),
report_panel_pskey STRING(16777216) OPTIONS(description='Technical Field: MicroStrategy internal Panel Stack Key PSKEY'),
report_panel_pkey STRING(16777216) OPTIONS(description='Technical Field: MicroStrategy internal Panel Key'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version NUMBER of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field 1 indicates the current record in case of several version'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (report_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - Table of Content (ToC) parameters used within PIT MicroStrategy reporting');