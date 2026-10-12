/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_FE_MSTR_REPORTING_LINES_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-20 Mike Davis      Checks formatting FK support (now removed)
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA added COMMIT
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC
REPORTING_LINE_SID
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_reporting_lines_1 (
reporting_line_id INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Unique ID of Reporting Hierarchie Line'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
reporting_type_id INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Unique ID of Reporting Hierarchie Type'),
reporting_type_descr STRING(16777216)
OPTIONS(description='Description of the type (e.g. regarded dimension) of the reporting page'),
reporting_line_sid INTEGER NOT NULL OPTIONS(description='Simple SID of the reporting line to have a unique CROSS JOIN'),
fe_mstr_relevant_fg INTEGER DEFAULT 1 NOT NULL OPTIONS(description='Flag indicates if used on FE_MSTR'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (reporting_line_sid, fe_mstr_relevant_fg, deleted_fg) NOT ENFORCED
) OPTIONS(description='Dimension Table for Frontend Reporting Lines');