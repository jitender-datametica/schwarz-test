/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_MEDIUM_GRP
#-------------------------------------------------------------------------------
# Description: Create DDL for static Medium Group Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-10-01 Aparna Rayanki    Initial version
#  1.1  2022-10-01 Mike Davis        Change name
#                                    Move group name in case we want it for the sid
#                                    Add	DEFAULT versioning
#  1.2  2022-04-01 Mike Davis        add mstr_sid
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
Questions:
    sid generation? md5 or current method (see load_static script)
*/

/*
VC:
MEDIUM_GRP_MSTR_SID
*/


-- DATA
 -- TECHNICAL KEYS
 -- Versioning
 -- BUSINESS KEY
 -- Technical Fields
 CREATE TABLE IF NOT EXISTS
ldl_p_lew_mart_pit.t_dim_adv_medium_grp_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3),
country_descr STRING(16777216),
medium_grp_name STRING(16777216) OPTIONS(description='Medium group name.'),
medium_grp_sid INTEGER NOT NULL OPTIONS(description='Unique system ID, sid, for the medium group.'),
medium_grp_sort_val INTEGER DEFAULT 99 NOT NULL OPTIONS(description='internal sorting value for the medium group'),
medium_grp_ignore_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='ignore flag for the medium group'),
medium_grp_always_vis_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='visible flag for the medium group'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL,
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL,
version_nr INTEGER DEFAULT 0 NOT NULL,
current_fg INTEGER DEFAULT 1 NOT NULL,
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
PRIMARY KEY (client_id, medium_grp_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Control Table with Medium Static Data');