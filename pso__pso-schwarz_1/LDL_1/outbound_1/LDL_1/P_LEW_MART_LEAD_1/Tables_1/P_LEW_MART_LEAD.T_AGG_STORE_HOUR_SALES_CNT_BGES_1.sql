/*
#-------------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG
#-------------------------------------------------------------------------------
# Interface : DDL for T_AGG_STORE_HOUR_SALES_CNT_BGES_1
#-------------------------------------------------------------------------------
# Description:  This table provides aggregated Bon Totals and Umsatz with 
#               the granularity of client/store/day/hour.
#               The aspect_id is fixed to 1 (BGES)
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2023-04-03 Prasanna Ranjan	 Initial Version
#-------------------------------------------------------------------------------
*/


-- Technical fields
 CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_store_hour_sales_cnt_bges_1 (
client_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Client ID e.g AT=1'),
move_to_store_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Unique key Region_1 surrogate key'),
dat_formdate DATE DEFAULT DATE '8888-12-31' NOT NULL OPTIONS(description='Reference date'),
time_hour_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Hour ID: 01 - 24'),
last_12_cy_week_fg BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Flag indicating if in last 12 weeks'),
cnt_customer_asis BIGNUMERIC(38,0) DEFAULT 0 OPTIONS(description='Number of receipts'),
dwh_created_ts DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME) NOT NULL
OPTIONS(description='Timestamp when record was created'),
dwh_updated_ts DATETIME OPTIONS(description='Technical field timestamp when record was updated'),
load_id INTEGER DEFAULT 0 NOT NULL OPTIONS(description='Technical Field ELT / ABInitio Process ID'),
PRIMARY KEY (client_id, move_to_store_id, dat_formdate, time_hour_id) NOT ENFORCED
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table for number of receipts and Umsatz EJR with half-hourly granularity');