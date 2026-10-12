/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_SOURCE_SYSTEM_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Source System Lookup Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-23 Mike Davis      Checks, formatting, FK support (now removed)
#-------------------------------------------------------------------------------
*/
/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_DIM_SOURCE_SYSTEM_2
------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_dim_source_system_2 (
source_system_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique Identifier of SOURCE System'),
source_system_name STRING(16777216) DEFAULT 'N/A' NOT NULL OPTIONS(description='Source System Name'),
source_system_descr STRING(16777216) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Source System Annotation further Description'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version Number of record ; Sequence starting from 0'),
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
PRIMARY KEY (source_system_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - Lookup PIT Source System');