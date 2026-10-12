/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_REL_NAN_IFG_UWG_WGI
#-------------------------------------------------------------------------------
# Describtion: Create DDL for original item			NUMBER dimension table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-09-06 Prasanna Ranjan    	Initial version
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ORIG_ITEM_MSTR_NR
ORIG_ITEM_MSTR_GID
ITEM_FAM_GRP_MSTR_SID
ITEM_FAM_GRP_MSTR_GID
SUB_ITEM_GRP_MSTR_SID
SUB_ITEM_GRP_MSTR_GID
ITEM_GRP_INT_MSTR_SID
ITEM_GRP_INT_MSTR_GID

*/


-- WGI
 -- UWG
 -- IFG
 -- Technical fields
 -- NAN
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_rel_nan_ifg_uwg_wgi
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Sid for original item nr (NaN)'),
orig_item_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
dat_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Birthdate of item'),
nan_valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Versioning: valid from'),
nan_valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Versioning: valid to'),
nan_version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Versioning: version nr'),
item_fam_grp_sid INTEGER NOT NULL OPTIONS(description='Sid for item family group. (UWG)'),
item_fam_grp_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
ifg_valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Versioning: valid from'),
ifg_valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Versioning: valid to'),
ifg_version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Versioning: version nr'),
sub_item_grp_sid INTEGER NOT NULL OPTIONS(description='Sid for item sub group. (UWG)'),
sub_item_grp_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
uwg_valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Versioning: valid from'),
uwg_valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Versioning: valid to'),
uwg_version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Versioning: version nr'),
item_grp_int_sid INTEGER NOT NULL OPTIONS(description='Sid for item international group'),
item_grp_int_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
wgi_valid_from_dt DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Versioning: valid from'),
wgi_valid_to_dt DATE DEFAULT DATE '9999-12-31' NOT NULL OPTIONS(description='Versioning: valid to'),
wgi_version_nr INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Versioning: version nr'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, orig_item_nr, item_fam_grp_sid, sub_item_grp_sid, item_grp_int_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Relation Table for NAN, IFG, UWG and WGI');