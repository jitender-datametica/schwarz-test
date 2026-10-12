/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for P_LEW_FE_MSTR_PIT.T_CNTL_FE_MSTR_PARAM
#-------------------------------------------------------------------------------
# Description: Create DDL for frontend MSTR parameter control table,
#              i.e. contains attribute IDs, HTML tags to build the URLs for report drilling links.
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz     Initial version
#  1.1  2021-08-30 Mike Davis       Checks, formatting
#  1.2  2021-09-16 Massimo Morelli  Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz     Reworked the structure after DM review
#  1.4  2022-07-13 Dirk Hering      Added schema prefix P_LEW_FE_MSTR_PIT, comments, changing the script for DevOps
#  2.0	2022-07-14 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/


-- Technical fields
 -- Versioning
 CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_cntl_fe_mstr_param (
fe_mstr_param_id INTEGER NOT NULL OPTIONS(description='Surrogate Key. IDENTTY COLUMN (1,1)'),
fe_mstr_param_name STRING(16777216) OPTIONS(description='Frontend Param Name'),
fe_mstr_param_value STRING(2500) OPTIONS(description='Frontend Param Value e.g. HTTP CSS Strings'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version Number of record; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field Flag::=1 indicates the current record in case of several version'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (fe_mstr_param_id, valid_from_dt, deleted_fg) NOT ENFORCED
)
OPTIONS(description='Frontend MSTR parameter control table, i.e. contains attribute IDs, HTML tags to build the URLs for report drilling links.');