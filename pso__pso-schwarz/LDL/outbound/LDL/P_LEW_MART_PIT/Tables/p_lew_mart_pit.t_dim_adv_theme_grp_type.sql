/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_DIM_ADV_THEME_GRP_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Action Type Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2023-06-26 Nikolai Toknov	INTEGER /NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INTEGER  - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#-------------------------------------------------------------------------------
*/


-- Versioning
 -- Technical fields (note: no source_system_id)
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_adv_theme_grp_type
(
theme_grp_type_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique ID.See COMMENTs below.'),
fe_mstr_relevant_fg INTEGER DEFAULT 0 OPTIONS(description='Flag indicates if used on FE_MSTR'),
theme_grp_type_sort_val INTEGER OPTIONS(description='Sort information for reporting purposes.'),
theme_grp_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
theme_grp_type_descr STRING(16777216) OPTIONS(description='(long)  description in local LANGUAGE (may be unavailable)'),
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
PRIMARY KEY (theme_grp_type_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Lookup table Action Type IDs');