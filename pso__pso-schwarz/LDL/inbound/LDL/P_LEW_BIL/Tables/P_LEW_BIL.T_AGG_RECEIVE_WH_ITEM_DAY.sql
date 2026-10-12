/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.T_AGG_RECEIVE_WH_ITEM_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  22.10.2024    Aparna Rayanki           Initial Version
#                                              https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/688269/
#----------------------------------------------------------------------------
*/


CREATE TABLE P_LEW_BIL.T_AGG_RECEIVE_WH_ITEM_DAY COMMENT = 'receive quantity and Buying val from Receive wareshouse'
(
	 client_id                  NUMBER(38,0) NOT NULL COMMENT 'country surrogate key',
	 wh_loc_sid                 NUMBER(38,0) NOT NULL COMMENT 'warehouse surrogate key',
	 src_wh_id                  NUMBER(38,0) NOT NULL COMMENT 'warehouse number',
	 orig_item_nr               NUMBER(38,0) NOT NULL COMMENT 'National Article Number',
	 dwh_cal_dt                 DATE         NOT NULL COMMENT 'transaction Date',
     curr_sid                   NUMBER(38,0) NOT NULL COMMENT 'currency surrogate key',
	 currency_iso_cd            VARCHAR(20)  COLLATE 'en-ci' COMMENT 'currency code in Euros and Local Currency',
     current_rcv_qty            NUMBER(38,5) COMMENT 'receive quantity of current day',
     current_rcv_buying_val     NUMBER(38,5) COMMENT 'buying value of current day',
	 current_buying_price       NUMBER(38,5) COMMENT 'buying val divide by rcv quantity of current day',
	 last_buying_price          NUMBER(38,5) COMMENT 'last available buying val divide by rcv quantity',
	 dwh_created                TIMESTAMP_NTZ(9) NOT NULL,
CONSTRAINT PK_T_AGG_RECEIVE_WH_ITEM_DAY PRIMARY KEY(client_id ,wh_loc_sid ,orig_item_nr ,dwh_cal_dt,curr_sid)
);

