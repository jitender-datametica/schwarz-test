/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2025
#-------------------------------------------------------------------------------
# Interface : DDL for DIM_REGION_HIER
#-------------------------------------------------------------------------------
# Describtion: Create DDL for flattened and Daily sliced Region_2 Dimension
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-07-01 Andreas Kurz    	Initial version
#  1.1  2021-07-26 Mike Davis      	Some tweaks, extra	NOT NULLs and warehouse_mstr_sid.
#  1.2  2021-08-20 Mike Davis      	Checks, formatting, FK support (now removed)
#  1.3  2022-01-24 Andreas Kurz		Reworked the structure after DM review
#  1.4  2022-02-11 Andreas Kurz		Added new column GEO_INFO_FG, STORE_LONGITUDE, STORE_ALTIDUDE
#  1.5  2022-02-13 Nikolai Toknov	Cosmetic changes
#  2.0	2022-07-13 Nikolai Toknov  Changing the script for DevOps
#  4.0  2023-11-06 Nikolai Toknov	Task 530802. [Architecture] Exclude using "virtual columns" that are not GA in database. Drop VC.
#-------------------------------------------------------------------------------
*/

/*
VC:
WAREHOUSE_MSTR_SID
*/


-- AKU 2022-02-10
 -- Technical Fields
 -- AKU 2021-07-26
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_pit.t_dim_region_hier_2
(
day_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Calendar_2 Day of the daily sliced flattened store-region_2 hierarchy_2'),
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g. 1=>AT'),
country_iso_cd STRING(3) OPTIONS(description='Country_2 ISO Code = WAWI Country_2 '),
country_descr STRING(16777216) OPTIONS(description='Country_2 Name'),
store_sid INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Surrogate ID For Store L1 Note: We need to investigate which field to use move_to_store_sid vs. store_sid'),
store_name STRING(16777216) OPTIONS(description='Store name'),
orig_store_nr INTEGER OPTIONS(description='Original Store NUMBER / code from Wawi'),
store_sales_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / Indicator if Store had a sales_2 on the day. (from POS)'),
geo_info_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag / indicator if the Store have a valid Longitude and Altidue Coordinates'),
store_longitude BIGNUMERIC(38,5) OPTIONS(description='Lonitude of the Store'),
store_latitude BIGNUMERIC(38,5) OPTIONS(description='Altidue of the Store'),
warehouse_sid INTEGER DEFAULT - 1 OPTIONS(description='Warehouse Surrogate ID L2'),
warehouse_name STRING(16777216) OPTIONS(description='Warehouse Name'),
orig_wh_nr INTEGER OPTIONS(description='Original Wahrehouse NUMBER  / code from Wawi'),
sub_region_sid INTEGER DEFAULT - 1 OPTIONS(description='[Future Use] Sub Region_2 L3. e.g. DE=23 L3 = S1 (süd 1)'),
sub_region_name STRING(16777216) OPTIONS(description='Description of Sub_Region'),
main_region_sid INTEGER DEFAULT - 1 OPTIONS(description='[Future use]: Main Region_2 L4. e.g. DE=23 S (Süd)'),
main_region_name STRING(16777216) OPTIONS(description='Description of Main Region_2'),
region_type_id STRING DEFAULT 'STD' OPTIONS(description='Standard (STD) or Individual region_2(IND)'),
region_type_descr STRING(16777216) DEFAULT 'Standard' OPTIONS(description='Region_2 Type Description'),
closed_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator if the Store is Closed'),
test_store_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator if the Store is a Test_2 Store'),
dummy_store_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator if the Store is a Dummy_2 Store'),
template_store_fg INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Flag / indicator if the Store is a Template Store'),
real_opening_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Flag / indicator if the Store Real Opening DATE. Unknown			DATEs will be transalted to 8888-12-31'),
opening_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Flag / indicator if the Store Opening DATE. Unknown			DATEs will be transalted to 8888-12-31'),
closing_dt DATE DEFAULT DATE '8888-12-31' NOT NULL
OPTIONS(description='Flag / indicator if the Store Closing DATE. Unknown			DATEs will be transalted to 8888-12-31'),
reject_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Flag indicates if record was rejected by DQ Rule, e.g. 1/0 or similar data issues'),
reject_reason_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Link to DQ Reject Reason Codes'),
source_system_id INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Technical Field: Source System. E.g. Manual / Static / PIT Internal / EJR / WAWI / Delivery / ADP'),
deleted_fg INTEGER DEFAULT 0 NOT NULL
OPTIONS(description='Logical Deleted Flag; indicates if the record was logically deleted'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (day_dt, client_id, store_sid, deleted_fg) NOT ENFORCED
) CLUSTER BY client_id, day_dt
OPTIONS(description='Dimension table flattened store-region_2 hierarchy_2');