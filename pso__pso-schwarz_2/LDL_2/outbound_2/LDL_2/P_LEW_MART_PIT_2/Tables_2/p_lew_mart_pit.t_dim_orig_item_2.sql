/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_ORIG_ITEM
#-------------------------------------------------------------------------------
# Describtion: Create DDL for original item_2			NUMBER dimension table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2022-05-11 Massimo Morelli    	Initial version
#  1.1  2022-05-30 Massimo Morelli    	Changed type of ORIG_ITEM_MSTR_NR
#  1.1  2022-05-30 Massimo Morelli    	Changed type of SCD_MD5, added ATTR_SEQ
#  1.2  2022-06-20 Prasanna Ranjan		Added DAT_VALID_FROM
#  2.0	2022-07-13 Nikolai Toknov  		Changing the script for DevOps
#  2.1  2022-07-18 Andreas Kurz			Changed STRING(100) --> STRING
#  2.2  2023-07-07 Andreas Kurz			Added BRAND_NAME and BRAND_TYPE_CD
#  3.0  2024-02-14 Prasanna Ranjan		Added new columns for PIT Increment 2 (PV)
#  4.0  2024-03-25 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
ORIG_ITEM_MSTR_NR
ORIG_ITEM_MSTR_GID

*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT;

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ORIG_ITEM_2
ADD BRAND_NAME			STRING 																COMMENT 'Brand_2 name.'

ALTER TABLE LDL.P_LEW_MART_PIT.T_DIM_ORIG_ITEM_2
ADD BRAND_TYPE_CD		STRING 																COMMENT 'Brand_2 type. Marke M or Eigenmarke EM'

*/


-- )
 -- (ORIG_ITEM_GID * 100) + CLIENT_ID

-- ) 														COMMENT 'Sid for original item_2 nr (NaN) * 100 +/- CLIENT_ID e.g. for client AT (1) and ORIG_ITEM_NR 1000 -> 100001, for ORIG_ITEM_NR -1000 -> -100001',

-- (ORIG_ITEM_NR * 100) + CLIENT_ID
 -- ORIG_ITEM_MSTR_GID	INTEGER		 AS (
 -- IFF(ORIG_ITEM_GID < 0,

-- IFF(ORIG_ITEM_NR < 0,
 -- WARNING: THIS IS NOT PK
 -- Technical fields
 -- (ORIG_ITEM_GID * 100) - CLIENT_ID,

-- ORIG_ITEM_MSTR_NR	INTEGER		 AS (
 -- (ORIG_ITEM_NR * 100) - CLIENT_ID,
 -- )

-- ) 														COMMENT 'Technical Field: MSTR GID',
 -- 
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_orig_item_2
(
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='Sid for original item_2 nr (NaN)'),
orig_item_gid INTEGER OPTIONS(description='key identity. NOT A PK'),
dat_valid_from DATE DEFAULT DATE '1900-01-01' NOT NULL OPTIONS(description='Birthdate of item_2'),
item_name STRING(16777216) OPTIONS(description='(short) item_2 name in local language'),
item_descr STRING(16777216) OPTIONS(description='(long) item_2 description in local language'),
item_int_descr STRING(16777216)
OPTIONS(description='(long) item_2 description in international language of centre (Deutsch)'),
item_fam_grp_sid INTEGER OPTIONS(description='Sid for item_2 family group.'),
sub_item_grp_sid INTEGER OPTIONS(description='Sid for sub item_2 group.'),
item_grp_int_sid INTEGER OPTIONS(description='Sid for item_2 group INTEGER .'),
brand_sid INTEGER OPTIONS(description='Sid for brand_2 of item.'),
brand_name STRING(16777216) OPTIONS(description='Brand_2 name.'),
brand_type_cd STRING(16777216) OPTIONS(description='Brand_2 type. Marke M or Eigenmarke EM'),
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
PRIMARY KEY (client_id, orig_item_nr, dat_valid_from, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Dimension table for Orig Item_2 _ MSTR use only');