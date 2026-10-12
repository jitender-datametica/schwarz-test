/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_inv_item_wh_ejr
#----------------------------------------------------------------------------
# History:
#  1.0  2021-07-06    Tris Bayliff          Initial
#                                           20210701_2876_Rohertragsletter_perf_ddl2
#                                           https://jira.schwarz/browse/REP2-9836
#  2.0  2021-08-02    Tris Bayliff          Switch to LEW_MART_MSI database
#                                           20210730_2897_Rohertragsletter_perf_ddl3
#                                           https://jira.schwarz/browse/REP2-10035
#  3.0  2021-09-29    Tris Bayliff          Change for SnowFlake
#                                           20210730_2897_Rohertragsletter_perf_ddl3
#                                           https://jira.schwarz/browse/REP2-10035
#
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_inv_item_wh_ejr (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Client identifier'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Warehouse identifier'),
inv_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Inventory identifier'),
inv_start_date DATE OPTIONS(description='Inventory start date'),
inv_end_date DATE OPTIONS(description='Inventory end date'),
item_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Item identifier'),
val_rtl_ejr_asis NUMERIC(18,5) OPTIONS(description='Sales value'),
val_rtl_net_ejr_asis NUMERIC(18,5) OPTIONS(description='Net sales value'),
val_return_ejr_asis NUMERIC(18,5) OPTIONS(description='Returns value'),
val_return_net_ejr_asis NUMERIC(18,5) OPTIONS(description='Net returns value'),
currency_iso_cd STRING COLLATE 'und:ci' NOT NULL OPTIONS(description='Currency ISO Code'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Record load Identifier'),
dwh_inserted DATETIME NOT NULL OPTIONS(description='Record inserted timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated timestamp')
) CLUSTER BY client_id
OPTIONS(description='Warehouse Item Inventory');