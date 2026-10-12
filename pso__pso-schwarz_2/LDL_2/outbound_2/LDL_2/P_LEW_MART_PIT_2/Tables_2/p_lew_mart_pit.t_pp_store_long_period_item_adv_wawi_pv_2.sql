/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for T_PP_STORE_LONG_PERIOD_ITEM_ADV_WAWI_PV_2
#-------------------------------------------------------------------------------
# Describtion: Create DDL for Per-Intermediate Fact Table dectection of WAWI-PV Periods
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#	1.0  2024-10-30 Andreas Kurz		Initial version
#-------------------------------------------------------------------------------
*/

/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE 		LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA          P_LEW_MART_PIT_2;
*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_pp_store_long_period_item_adv_wawi_pv_2 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g, AT:==1'),
item_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Item_2 Variant (Case Size)'),
store_sid INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_2 surrogate key'),
adv_week_id INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Advertising Week, derived from the PC_START_DT and StartofAdvWeek Day of Client Settings'),
adv_week_id_prev INTEGER DEFAULT 888853 NOT NULL
OPTIONS(description='Advertising Week [Previous] before Splitting, derived from the PC_START_DT and StartofAdvWeek Day of Client Settings'),
pch_start_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Start Tage Ebene Filiale PC'),
pch_end_dt DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='End Tage Ebene Filiale PC'),
pch_length_of_period BIGNUMERIC(38,0) OPTIONS(description='Länge der Periode auf Ebene Filiale'),
pv_period_length_max_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Indicator[0|1] 1::=if the detected PC-Period is > Param @[PV_PERIOD_LENGTH_MAX], otherwise 0'),
pch_start_dt_prev DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Start Tage Ebene Filiale PC [Previous] before Splitting,'),
pch_end_dt_prev DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='End Tage Ebene Filiale PC [Previous] before Splitting,'),
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
PRIMARY KEY (client_id, store_sid, item_sid, adv_week_id, pch_start_dt, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, adv_week_id
OPTIONS(description='PreIntermediate Table used for the WaWi-PV Period Detection Algorithm. Step 2. Periods detected on Long Periods on Store / Item_2 Level');