/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   30-06-2023   Aleksander Bialek   Adding this comment and header to the initial version which was deployed approx 15.05.2023 (Azure Devops WI:461587)
#                                       
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_lead.t_agg_avg_buy_price_str_day_itm_2
(
	client_id NUMBER(38,0),
	st_loc_sid NUMBER(38,0),
	orig_item_nr NUMBER(38,0),
	dat_valid_from DATE,
	dwh_cal_dt DATE,
	sales_net_qty NUMBER(32,5),
	sales_net_val NUMBER(38,11),
	ek_price_val NUMBER(38,12)
);