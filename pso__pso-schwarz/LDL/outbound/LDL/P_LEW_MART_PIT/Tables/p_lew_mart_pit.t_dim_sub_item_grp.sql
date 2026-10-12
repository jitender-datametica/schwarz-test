/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_SUB_ITEM_GRP
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Item Group Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-10 Massimo Morelli    	Initial version
#  2.0	2022-07-13 Nikolai Toknov  		Changing the script for DevOps
#  2.1 	2022-07-18 Andreas Kurz			Changed STRING(150)-->STRING
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
SUB_ITEM_GRP_MSTR_SID
SUB_ITEM_GRP_MSTR_GID

*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_sub_item_grp (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
sub_item_grp_sid INTEGER NOT NULL OPTIONS(description='Sid for item sub group. (UWG)'),
sub_item_grp_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
sub_item_grp_name STRING(16777216) OPTIONS(description='Item sub group name.'),
sub_item_grp_src_cd STRING(16777216) OPTIONS(description='Item sub group Wawi Source Code. Business Key'),
sub_item_grp_descr STRING(16777216) OPTIONS(description='Item sub group description (local)'),
sub_item_grp_int_descr STRING(16777216) OPTIONS(description='Item sub group description (international)'),
item_grp_int_sid INTEGER OPTIONS(description='Sid for item international group'),
valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Versioning: valid from'),
valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Versioning: valid to'),
version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Versioning: version nr'),
current_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Versioning: current flag: 1-->current version ; 0-->not current version'),
scd_key_md STRING OPTIONS(description='Slowly Changing Dimension (SCD) MD Key. Tracking the version relevant columns'),
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
PRIMARY KEY (client_id, sub_item_grp_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, sub_item_grp_sid
OPTIONS(description='Dimension table for Sub Item Group');