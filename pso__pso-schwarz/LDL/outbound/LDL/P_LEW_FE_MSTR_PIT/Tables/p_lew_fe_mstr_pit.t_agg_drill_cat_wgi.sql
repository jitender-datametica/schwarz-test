/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_CAT_WGI
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from category item group international (WGI) 
# to the category sub item groups (UWGs) in this WGI. This table has the links for Region (WH), Advertising Week, 
# compared to a related Advertising week, which could be up to 53 weeks in the past.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  2.3  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  4.1	2024-07-08 K Lukaszewska	Column DRILL_TO_UWGS_LINK_HTML_FILIAL added
#  4.2  2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#  4.3  2025-03-24 Nikolai Toknov	Change for Azure-pipeline
#-------------------------------------------------------------------------------
*/

/*

USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE SCHEMA			P_LEW_MART_PIT;

ALTER TABLE LDL.P_LEW_FE_MSTR_PIT.T_AGG_DRILL_CAT_WGI
ADD ACTION_TYPE_ID 				INTEGER			NOT NULL DEFAULT -1000						COMMENT 'Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'


*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_drill_cat_wgi (
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country ISO Code = WAWI Country '),
country_descr STRING(16777216) OPTIONS(description='Country Name'),
warehouse_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse NUMBER  / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)'),
reporting_line_sid INTEGER NOT NULL
OPTIONS(description='Hierarchy level NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
item_grp_int_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='UWG orig Item number Surrogate GID - As-Was CROSS JOIN key for Frontend'),
item_grp_int_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
item_grp_int_sid INTEGER NOT NULL OPTIONS(description='SID for item group international (WGI)'),
item_grp_int_mstr_sid INTEGER OPTIONS(description='SID for item group international (WGI) (MSTR formatted)'),
item_grp_int_src_cd STRING(16777216) OPTIONS(description='Item Code for international group from source system.'),
item_grp_int_name STRING(16777216) OPTIONS(description='Item International group name.'),
action_type_id INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'),
drill_to_uwgs_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows all UWGs of this item group international (WGI)'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, reporting_line_sid, item_grp_int_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Frontend Drilling Table, containing links from category item group international (WGI) to the category sub item groups (UWGs) in this WGI. This table has the links for Region (WH), Advertising Week, compared to a related Advertising week, which could be up to 53 weeks in the past.');