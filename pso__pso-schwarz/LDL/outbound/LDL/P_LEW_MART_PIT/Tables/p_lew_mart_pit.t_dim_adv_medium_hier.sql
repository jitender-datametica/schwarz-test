/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ADV_MEDIUM_HIER
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Medium Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.2  2022-03-13 Mike Davis      	Bring into line with current PitOnCloud
#  1.4  2022-04-05 Mike Davis      	mstr_sids now from the medium to group mapping
#  1.5  2022-07-06 Andreas Kurz		Reworked structured aligned naming conventions
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
MEDIUM_MSTR_SID
MEDIUM_GRP_MSTR_SID
MEDIUM_NAME_UPPER ?

*/


-- MEDIUM_GRP_MSTR_SID		INTEGER			NOT NULL	DEFAULT -1 									COMMENT '[VC] MSTR surrogate Key',

-- MEDIUM_NAME_UPPER		STRING 																COMMENT '(short) medium name in local language: unique version for SID (trimmed and uppercase)',

-- Medium Level - Lowest Level of Granularity
 -- Technical Fields

-- MEDIUM_MSTR_SID			INTEGER			NOT NULL	DEFAULT -1 									COMMENT '[VC] MSTR surrogate Key',

-- Medium Grp Level - Top Level
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_adv_medium_hier (
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Calendar Day of the daily sliced flattened item hierarchy'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
medium_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the medium (simply the channel_sid).'),
medium_grp_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Unique system ID, sid, for the medium group (simply the channel_grp_sid).'),
medium_name STRING(16777216)
OPTIONS(description='(short) medium name in local language: first version to be found case insensitive (trimmed) - the one displayed'),
medium_name_ldescr STRING(16777216)
OPTIONS(description='(long) medium description concate with ADP medium CD . debugging purposes'),
medium_sort_val INTEGER OPTIONS(description='internal sorting value for the medium'),
medium_grp_name STRING(16777216) OPTIONS(description='Medium group name.'),
medium_grp_sort_val INTEGER DEFAULT 99 NOT NULL OPTIONS(description='internal sorting value for the medium'),
medium_ignore_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Indicator / Flag Medium Ignore'),
medium_grp_lidlplus_fg INTEGER DEFAULT 0 OPTIONS(description='Indicator / Flag Medium Grouping on Lidl Plus '),
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
PRIMARY KEY (client_id, day_dt, medium_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Dimension table item hierarchy - on a daily basis');