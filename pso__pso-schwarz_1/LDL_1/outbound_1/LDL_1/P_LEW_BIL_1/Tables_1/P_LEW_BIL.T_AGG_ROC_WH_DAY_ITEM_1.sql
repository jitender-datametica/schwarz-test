/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_ROC_WH_DAY_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  05.02.2024    Aparna Rayanki           Initial Version
#  1.1  21.10.2024    Aparna Rayanki           Added prices columns
#  1.2  27.1.2026     Ivan Ivanov              Added cluster key to improve performance
#                                              https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/682357/
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_roc_wh_day_item_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='country_1 surrogate key'),
loc_sid_wh BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse surrogate key'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Article surrogate key'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='transaction Date'),
listing_type_id_hist BIGNUMERIC(38,0) NOT NULL OPTIONS(description='listungsart hist id'),
stock_fg BIGNUMERIC(38,0) NOT NULL OPTIONS(description='stock>=0 THEN 1 ELSE 0'),
qty_sales_avg_35_days_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='average sales_1 qty of last 35 calendar_1 days >=0 THEN 1 ELSE 0'),
item_group_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='item_grp_int_cd IN (\'4\',\'40\',\'5\',\'50\',\'6\',\'60\') OR sig.src_subitemgrp_cd IN (\'74\',\'78\') THEN 1 ELSE 0'),
qty_piece_ejr_asis NUMERIC(18,5) OPTIONS(description='piece quantity from EJR'),
qty_weight_ejr_asis NUMERIC(18,5) OPTIONS(description='weight quantity from EJR'),
qty_return_ejr_asis NUMERIC(18,5) OPTIONS(description='return quantity from EJR'),
qty_piece_stc_wh NUMERIC(18,5) OPTIONS(description='stock'),
qty_total_adj_sales_avg_35_days NUMERIC(18,5) OPTIONS(description='average sales_1 quantity of last 35 calendar_1 days'),
current_wh_stc_retail_net_price BIGNUMERIC(38,5) OPTIONS(description='current day net price'),
last_wh_stc_retail_net_price BIGNUMERIC(38,5)
OPTIONS(description='last available net price when current day net price is missing'),
dwh_created DATETIME NOT NULL,
PRIMARY KEY (client_id, loc_sid_wh, item_sid, dwh_cal_dt) NOT ENFORCED
) CLUSTER BY client_id, dwh_cal_dt
OPTIONS(description='Range of Coverage');