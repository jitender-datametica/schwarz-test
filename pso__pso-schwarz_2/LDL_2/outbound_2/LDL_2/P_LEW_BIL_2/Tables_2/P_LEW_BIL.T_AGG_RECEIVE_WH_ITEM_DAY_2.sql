/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_RECEIVE_WH_ITEM_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  22.10.2024    Aparna Rayanki           Initial Version
#                                              https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/688269/
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_bil.t_agg_receive_wh_item_day_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='country_2 surrogate key'),
wh_loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse surrogate key'),
src_wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='warehouse number'),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='National Article Number'),
dwh_cal_dt DATE NOT NULL OPTIONS(description='transaction Date'),
curr_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='currency surrogate key'),
currency_iso_cd STRING(20) COLLATE 'und:ci' OPTIONS(description='currency code in Euros and Local Currency'),
current_rcv_qty BIGNUMERIC(38,5) OPTIONS(description='receive quantity of current day'),
current_rcv_buying_val BIGNUMERIC(38,5) OPTIONS(description='buying value of current day'),
current_buying_price BIGNUMERIC(38,5) OPTIONS(description='buying val divide by rcv quantity of current day'),
last_buying_price BIGNUMERIC(38,5) OPTIONS(description='last available buying val divide by rcv quantity'),
dwh_created DATETIME NOT NULL,
PRIMARY KEY (client_id, wh_loc_sid, orig_item_nr, dwh_cal_dt, curr_sid) NOT ENFORCED
) OPTIONS(description='receive quantity and Buying val from Receive wareshouse');