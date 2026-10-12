/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ACTION_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Action Type Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/


-- Technical fields (note: no source_system_id)
 -- Versioning
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_action_type_2
(
action_type_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique ID.See COMMENTs below.'),
fe_mstr_relevant_fg INTEGER DEFAULT 0 OPTIONS(description='Flag indicates if used on FE_MSTR'),
action_type_sort_val INTEGER OPTIONS(description='Sort information for reporting purposes.'),
action_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
action_type_descr STRING(16777216) OPTIONS(description='(long)  description in local LANGUAGE (may be unavailable)'),
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
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (action_type_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Lookup table Action Type IDs');