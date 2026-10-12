/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_DRILL_THEME_2
#-------------------------------------------------------------------------------
# Description: Create DDL for Frontend Drilling Table, containing links from Advertising Theme to the history of the Theme via 
# calendar_2 icon and separately to its items via the magnify icon. This table has the links for Region_2 (WH), Advertising Week. 
# Comparison weeks are not needed, because there are no related week comparisons on history or item_2 level.
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-08-12 Dirk Hering     	Fixes, formatting
#  1.2	2021-09-13 Massimo Morelli 	Fixed SCHEMA
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-07-08 Dirk Hering      Changed THEME_... to THEME_GRP_... columns
#  2.0	2022-07-12 Nikolai Toknov  Changing the script for DevOps
#  2.1	2022-07-22 Andreas Kurz		Added _GID columns for MSTR As-Was CROSS JOIN
#  2.2  2022-10-12 Nikolai Toknov   Add CLUSTER BY (CLIENT_ID)
#  2.3  2023-01-25 Andreas Kurz		Adding ACTION_TYPE_ID Column Default -1000 n/A
#  3.0	2023-06-26 Nikolai Toknov	INTEGER /NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INTEGER  - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#  3.1  2023-09-06 Andreas Kurz 	Changes INTEGER /NAT. Release v.5.15. B-0011293A-AP0186978 Anpassung Mapping INTEGER  / NAT aus APT
#									Adding THEME_GRP_CAT MSTR attributes
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#  5.0  2024-06-19 K Lukaszewska	Column DRILL_TO_ITEMS_LINK_HTML_FILIAL added
#  5.1	2025-03-05 K Lukaszewska	Reworked Structure based on Increment PV 2.1 business requirements (FE-MSTR)
#-------------------------------------------------------------------------------
*/

/*

USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA 		P_LEW_FE_MSTR_PIT; 

--DROP TABLE LDL.P_LEW_FE_MSTR_PIT.T_AGG_DRILL_THEME_2;
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_fe_mstr_pit.t_agg_drill_theme_2 (
client_id INTEGER NOT NULL OPTIONS(description='Client id'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
warehouse_gid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Warehouse Surrogate GID - As-Was CROSS JOIN key for Frontend'),
warehouse_mstr_gid INTEGER OPTIONS(description='Technical Field: MSTR GID'),
warehouse_sid INTEGER NOT NULL OPTIONS(description='Warehouse Surrogate ID'),
warehouse_mstr_sid INTEGER OPTIONS(description='Warehouse Surrogate ID MSTR Key'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Warehouse NUMBER / code from Wawi'),
adv_week_id INTEGER NOT NULL OPTIONS(description='Advertising week BK'),
adv_week_mstr_id INTEGER
OPTIONS(description='Advertising week MSTR Key (AdvWeek No. concatenated with 2-digit client ID)'),
reporting_line_sid INTEGER NOT NULL
OPTIONS(description='Hierarchy_2 level NUMBER to identify the individual reporting line (row) of e.g. a precalculated summary line.'),
reporting_line_descr STRING(16777216) OPTIONS(description='Description of the Reporting Line'),
theme_grp_type_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique ID.See COMMENTs below.'),
theme_grp_type_sort_val INTEGER OPTIONS(description='Sort information for reporting purposes.'),
theme_grp_type_name STRING(16777216) OPTIONS(description='(short) name in local LANGUAGE'),
theme_grp_type_descr STRING(16777216) OPTIONS(description='(long)  description in local LANGUAGE (may be unavailable)'),
theme_grp_int_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description=' Unique system ID, sid, for the theme INTEGER group.'),
theme_grp_int_mstr_sid INTEGER
OPTIONS(description=' Unique system ID, sid, for the theme INTEGER group + Client_ID, as MSTR Key'),
theme_grp_int_name STRING(16777216) OPTIONS(description=' Theme INTEGER group name.'),
theme_grp_int_sort_val INTEGER
OPTIONS(description=' internal sorting value for the INTEGER theme (ordered by Theme group Name)'),
theme_grp_nat_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description=' Unique system ID, sid, for the theme nat group.'),
theme_grp_nat_mstr_sid INTEGER
OPTIONS(description=' Unique system ID, sid, for the theme nat group + Client_ID, as MSTR Key'),
theme_grp_nat_name STRING(16777216) OPTIONS(description=' Theme nat group name.'),
theme_grp_nat_sort_val INTEGER
OPTIONS(description=' internal sorting value for the nat theme (ordered by Theme group Name)'),
theme_grp_nat_cat_sid INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description=' Unique system ID, sid, for the theme nat group category.'),
theme_grp_nat_cat_mstr_sid INTEGER
OPTIONS(description=' Unique system ID, sid, for the theme nat group category + Client_ID, as MSTR Key'),
theme_grp_nat_cat_name STRING(16777216) OPTIONS(description=' Theme nat group name category.'),
theme_grp_nat_cat_sort_val INTEGER
OPTIONS(description=' internal sorting value for the nat theme category (ordered by Theme group Name)'),
theme_grp_main_mstr_sid INTEGER
OPTIONS(description=' Unique system ID, sid, for the theme group + Client_ID, as MSTR Key'),
theme_grp_main_name STRING(16777216) OPTIONS(description=' Theme group name.'),
action_type_id INTEGER DEFAULT - 1000 NOT NULL
OPTIONS(description='Action type id.2000 = Reporting Line Total, -1000 = Undefined/No Action, 1 = PV, 2 = NF, 3 = FA respectively.'),
drill_to_items_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows all items of this adv theme'),
drill_to_hist_link_html STRING(16777216)
OPTIONS(description='Link to the target detailed report, which shows the history of this adv theme: The previous advertising weeks, in which there have been advertisings in this theme.'),
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
PRIMARY KEY (client_id, warehouse_sid, adv_week_id, reporting_line_sid, theme_grp_int_sid, theme_grp_nat_sid, deleted_fg
 ) NOT ENFORCED
) CLUSTER BY client_id
OPTIONS(description='Frontend Drilling Table, containing links from Advertising Theme to the history of the Theme via calendar_2 icon and separately to its items via the magnify icon. This table has the links for Region_2 (WH), Advertising Week. Comparison weeks are not needed, because there are no related week comparisons on history or item_2 level.');