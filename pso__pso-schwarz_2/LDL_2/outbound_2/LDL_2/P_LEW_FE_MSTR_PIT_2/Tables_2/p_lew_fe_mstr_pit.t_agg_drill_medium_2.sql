/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_MEDIUM_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing drilling links from Advertising Medium (and Medium Group) 
# to the history of the Medium (Medium Group) via calendar_2 icon and separately to its items via the magnify icon.
# This table has the links for Region_2 (WH), Advertising Week. Comparison weeks are not needed, because there are no related 
# week comparisons on history or item_2 level.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.2  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  2.3  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  5.0  2024-06-20 K Lukaszewska	Added column DRILL_TO_ITEMS_LINK_HTML_FILIAL
#  5.1  2024-07-17 K Lukaszewska	Added column DRILL_TO_HIST_LINK_HTML_FILIAL
#  5.2  2025-02-10 K Lukaszewska		Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE			R_LDL_D_PIT_ETL;
USE WAREHOUSE		WH_LDL_D_PIT_ETL_S;
USE DATABASE		LDL_PRODUCTION_CLONE_PIT_R60001;
--USE DATABASE		LDL_PRODUCTION_CLONE_PIT_CLONE_AP0123442_AKTIONSTYPEN;
--USE DATABASE 		LDL_PRODUCTION_CLONE_HRK2EUR_PIT;
USE SCHEMA			P_LEW_MART_PIT_2;

ALTER TABLE LDL.P_LEW_FE_MSTR_PIT.T_AGG_DRILL_MEDIUM_2
DROP COLUMN DRILL_TO_HIST_LINK_HTML_FILIAL
DROP COLUMN DRILL_TO_ITEMS_LINK_HTML_FILIAL

DESC TABLE P_LEW_FE_MSTR_PIT.T_AGG_DRILL_MEDIUM_2
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_drill_medium_2 (
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
warehouse_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse NUMBER / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)'),
reporting_line_sid INTEGER NOT NULL
OPTIONS(description='Hierarchy_2 level NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
medium_sid INTEGER NOT NULL OPTIONS(description='Advertising Medium SID'),
medium_mstr_sid INTEGER OPTIONS(description='Advertising Medium SID (MicroStrategy Formatted)'),
medium_name STRING(16777216) OPTIONS(description='(short) medium name in local LANGUAGE'),
medium_grp_sid INTEGER NOT NULL OPTIONS(description='Advertising Medium Group SID'),
medium_grp_mstr_sid INTEGER OPTIONS(description='Advertising Medium Group SID (MicroStrategy Formatted)'),
medium_grp_name STRING(16777216) OPTIONS(description='Medium group name.'),
action_type_id INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Action type id. -2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'),
drill_to_items_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows all items of this adv medium (or adv medium group, distinguished by reporting line)'),
drill_to_hist_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows the history of this adv medium (or adv medium group, distinguished by reporting line): The previous advertising weeks, in which there have been advertisings in this medium or medium group.'),
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
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, reporting_line_sid, medium_sid, medium_grp_sid, deleted_fg)
NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Frontend Drilling Table, containing drilling links from Advertising Medium (and Medium Group) to the history of the Medium (Medium Group) via calendar_2 icon and separately to its items via the magnify icon. This table has the links for Region_2 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on history or item_2 level.');