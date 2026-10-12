/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_P_F_PRICE_CHANGE_PV
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Intermediate Fact Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
# 1.0 2024-01-31 Andreas Kurz	Initial version
# 1.1 2024-11-04 Implement Name Changes on DDL
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT; 

--DESC TABLE P_LEW_MART_PIT.T_T_P_F_PRICE_CHANGE_PV
*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_p_f_price_change_pv (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Day of Sales'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region surrogate key'),
orig_item_nr INTEGER OPTIONS(description=''),
item_sid INTEGER NOT NULL OPTIONS(description=''),
pcwo_reason_id INTEGER OPTIONS(description=''),
pcwo_reason_desc STRING(16777216) OPTIONS(description=''),
pch_day_pricegroup_fg INTEGER OPTIONS(description=''),
discount_value_promodesigner BIGNUMERIC(38,5) OPTIONS(description=''),
discount_value_lidlplus BIGNUMERIC(38,5) OPTIONS(description=''),
pch_baseline_fg INTEGER OPTIONS(description=''),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
source_system_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Source System EJR / WAWI / Delivery'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, day_dt, store_sid, item_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Intermediate Fact Table PC Price Change (PV)');