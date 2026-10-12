/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025 
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_PERIOD_1
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Frontend Drilling Table, containing links from Advertising Period 
# (or Action Type Total) to the Items of this period (action type). This table has the links for Region_1 (WH), 
# Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on item_1 level.
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
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  5.0  2024-06-20 K Lukaszewska	Column DRILL_TO_ITEMS_LINK_HTML_FILIAL added
#  5.1  2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*
USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE SCHEMA			P_LEW_MART_PIT_1;

DESC TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_PERIOD_1
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_drill_period_1 (
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country_1 ISO Code = WAWI Country_1 '),
country_descr STRING(16777216) OPTIONS(description='Country_1 Name'),
warehouse_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='[VC] Warehouse Surrogate ID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse NUMBER / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key(AdvWeek No. concatenated with 2-digit client ID)'),
action_type_id INTEGER NOT NULL
OPTIONS(description='Action type id.-2 = Reporting Line Total, -1 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'),
action_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
adv_period_id INTEGER NOT NULL OPTIONS(description='Unique identifier of Adv. Period'),
adv_period_mstr_id INTEGER
OPTIONS(description='[VC] Needed for MSTR Reportinge.g. 2021241304 Adv.Period from Mon to Wednesday Adv.Week 2021/24 for Country_1 04 (CH)'),
adv_period_descr STRING(16777216) OPTIONS(description='Adv. Period Description'),
drill_to_items_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows all items of this adv theme'),
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
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, action_type_id, adv_period_id, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Frontend Drilling Table, containing links from Advertising Period (or Action Type Total) to the Items of this period (action type). This table has the links for Region_1 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on item_1 level.');