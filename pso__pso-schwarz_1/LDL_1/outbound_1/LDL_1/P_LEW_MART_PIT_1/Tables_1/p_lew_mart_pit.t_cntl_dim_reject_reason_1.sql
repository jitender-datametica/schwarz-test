/*
#-------------------------------------------------------------------------------
# LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_CNTL_DIM_REJECT_REASON_1
#-------------------------------------------------------------------------------
# Description: Create DDL for Reject Reason Lookup Table - holding the reject reasons during the ETL Process
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-16 Dirk Hering     Fixes, formatting
#  1.2  2021-08-20 Mike Davis      Checks, FK support (now removed)
#-------------------------------------------------------------------------------
*/


/*
---------------------------------------------------------------------
0. Create DIM Table in T_CNTL_DIM_REJECT_REASON_1
------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_cntl_dim_reject_reason_1 (
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique Identifier of Reject Reason'),
reject_reason_descr STRING(1500) DEFAULT 'N/A' NOT NULL
OPTIONS(description='Reject Reason Annotation further description'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL
OPTIONS(description='Technical field Data Historization Valid from '),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Technical field Data Historization Valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Version Number of record ; Sequence starting from 0'),
current_fg INTEGER DEFAULT 1 NOT NULL
OPTIONS(description='Technical Field 1 indicates the current record in case of several version'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / AB>Initio Process ID'),
PRIMARY KEY (reject_reason_id, valid_from_dt, deleted_fg) NOT ENFORCED
) OPTIONS(description='Control Table - Lookup PIT Reject Reason - holding the reject reasons during the ETL Process');