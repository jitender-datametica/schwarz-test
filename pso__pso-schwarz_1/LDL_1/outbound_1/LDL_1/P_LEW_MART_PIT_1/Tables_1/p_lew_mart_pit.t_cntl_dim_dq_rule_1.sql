/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_DQ_RULE_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Control Dimension table for DQ (Data Quality) Rules
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-23 Mike Davis      Checks, formatting, FK support (removed)
#                                  ***Note***: there is a problem with the FK for
#                                  A_LEVEL_ID since this is generated using
#                                  IDENTITY(1, 1) in the corresponding cntl_dim
#                                  so there is no -1 value
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  2.1  2024-04-15 Nikolai Toknov  Fix issue DDLvsGIT
#-------------------------------------------------------------------------------
*/


-- Aggregation Level
 -- Technical fields
 -- DQ_SEVERITY_LEVEL_DESCR	STRING,

/* Rules should be given an explicit ID in this static table (not IDENTITY),
    to keep it static for frontend DQ reporting, for later referencing, not changing when inserting new rules. */
-- DQ_SEVERITY_LEVEL_ID	INTEGER		,
 -- Versioning
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_dim_dq_rule_1 (
dq_rule_id INTEGER NOT NULL OPTIONS(description='Autoincrement Identifier (-1,1)'),
dq_rule_descr STRING(500) OPTIONS(description='Rule Description (Extended)'),
dq_rule_fe_descr STRING(50) OPTIONS(description='Rule Description (short for Reporting Display)'),
a_level_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Aggregation Level Identifier'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version			NUMBER of record ; Sequence starting from 0'),
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
PRIMARY KEY (dq_rule_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Dimension table for DQ (Data Quality) Rules');