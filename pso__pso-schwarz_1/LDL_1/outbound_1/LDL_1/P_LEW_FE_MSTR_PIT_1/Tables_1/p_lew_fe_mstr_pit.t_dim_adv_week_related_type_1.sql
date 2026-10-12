/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_WEEK_2_ADV_WEEK_PREV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Adv.Period Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    Initial version
#  1.1  2021-08-23 Mike Davis      Checks, formatting, FK support (now removed)
#  1.2	2021-09-13 Massimo Morelli Fixed SCHEMA, added COMMIT
#  2.0	2022-04-12 Nikolai Toknov  Changing the script for DevOps
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_dim_adv_week_related_type_1 (
related_type_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='The type ID of the related week comparison'),
related_type_descr STRING(16777216) DEFAULT 'N/A'
OPTIONS(description='The German type description of the related week  comparison, to show in the reporting'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (related_type_id, deleted_fg) NOT ENFORCED
) OPTIONS(description='Dimension table for Adv.-Week Related Type');