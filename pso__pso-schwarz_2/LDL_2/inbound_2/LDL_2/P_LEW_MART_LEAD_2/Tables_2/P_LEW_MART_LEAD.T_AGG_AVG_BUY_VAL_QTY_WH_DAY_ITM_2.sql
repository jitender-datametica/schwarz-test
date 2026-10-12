/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.1   18-09-2023   Aleksander Bialek   Initial Version (materialized table for EK prices needed for final table/views for Kalkulation basis Abverkauf)
#                                       
#----------------------------------------------------------------------------
*/

CREATE TABLE p_lew_mart_lead.t_agg_avg_buy_val_qty_wh_day_itm_2 (
	CLIENT_ID NUMBER(38,0),
	LOC_SID_WH NUMBER(38,0),
	WH_ID NUMBER(38,0),
	ORIG_ITEM_NR NUMBER(38,0),
	DAT_VALID_FROM DATE,
	DWH_CAL_DT DATE,
	EK_PRC_NOMINATOR_VAL NUMBER(38,5),
	EK_PRC_DENOMINATOR_QTY NUMBER(38,8),
	EK_PRICE_VAL NUMBER(38,11)
);

