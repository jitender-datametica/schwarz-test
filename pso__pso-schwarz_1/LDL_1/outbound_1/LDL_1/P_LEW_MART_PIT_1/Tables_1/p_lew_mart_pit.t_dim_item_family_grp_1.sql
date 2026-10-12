/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ITEM_FAM_GRP
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Item_1 Group Dimension Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-09-06 Prasanna Ranjan	   	Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/
/*
VC:
ITEM_FAM_GRP_MSTR_SID
ITEM_FAM_GRP_MSTR_GID

*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_item_family_grp_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
item_fam_grp_sid INTEGER NOT NULL OPTIONS(description='Sid for item_1 family group. (UWG)'),
item_fam_grp_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
item_fam_grp_src_id INTEGER OPTIONS(description='Item_1 family group source ID'),
item_fam_grp_src_cd STRING(16777216) OPTIONS(description='Item_1 family group Wawi Source Code. Business Key'),
item_fam_grp_name STRING(16777216) OPTIONS(description='Item_1 family group name.'),
item_fam_grp_descr STRING(16777216) OPTIONS(description='Item_1 family group description (local)'),
item_fam_grp_int_descr STRING(16777216) OPTIONS(description='Item_1 family group description (international)'),
sub_item_grp_sid INTEGER OPTIONS(description='Sid for sub item_1 grp'),
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
PRIMARY KEY (client_id, item_fam_grp_sid, valid_from_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, item_fam_grp_sid
OPTIONS(description='Dimension table for item_1 family Group');