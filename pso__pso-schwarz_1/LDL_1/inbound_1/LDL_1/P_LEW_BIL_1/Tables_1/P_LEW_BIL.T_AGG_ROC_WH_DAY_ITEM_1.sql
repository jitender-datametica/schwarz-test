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
CREATE TABLE P_LEW_BIL.T_AGG_ROC_WH_DAY_ITEM_1 CLUSTER BY (CLIENT_ID,DWH_CAL_DT)	COMMENT = 'Range of Coverage'
(
 client_id                              NUMBER(38,0)   NOT NULL COMMENT 'country_1 surrogate key',
loc_sid_wh                              NUMBER(38,0)   NOT NULL COMMENT 'warehouse surrogate key',
item_sid                                NUMBER(38,0)   NOT NULL COMMENT 'Article surrogate key',
dwh_cal_dt                              DATE           NOT NULL COMMENT 'transaction Date',
listing_type_id_hist                    NUMBER(38,0)   NOT NULL COMMENT 'listungsart hist id', 
stock_fg                                NUMBER(38,0)   NOT NULL  COMMENT 'stock>=0 THEN 1 ELSE 0',
qty_sales_avg_35_days_fg                NUMBER(38,0)   NOT NULL  COMMENT 'average sales_1 qty of last 35 calendar_1 days >=0 THEN 1 ELSE 0',
item_group_fg                           NUMBER(38,0)   NOT NULL  COMMENT 'item_grp_int_cd IN (''4'', ''40'', ''5'', ''50'', ''6'', ''60'') OR sig.src_subitemgrp_cd IN (''74'', ''78'') THEN 1 ELSE 0',
qty_piece_ejr_asis	                    NUMBER(18,5)   COMMENT 'piece quantity from EJR',
qty_weight_ejr_asis                     NUMBER(18,5)   COMMENT 'weight quantity from EJR',
qty_return_ejr_asis                     NUMBER(18,5)   COMMENT 'return quantity from EJR',               
qty_piece_stc_wh                        NUMBER(18,5)   COMMENT 'stock',
qty_total_adj_sales_avg_35_days         NUMBER(18,5)   COMMENT 'average sales_1 quantity of last 35 calendar_1 days',
current_wh_stc_retail_net_price         NUMBER(38,5)   COMMENT 'current day net price',
last_wh_stc_retail_net_price            NUMBER(38,5)   COMMENT 'last available net price when current day net price is missing',
dwh_created                             TIMESTAMP_NTZ(6) NOT NULL,
CONSTRAINT PK_T_AGG_ROC_WH_DAY_ITEM PRIMARY KEY(client_id ,loc_sid_wh ,item_sid ,dwh_cal_dt)
)
;

