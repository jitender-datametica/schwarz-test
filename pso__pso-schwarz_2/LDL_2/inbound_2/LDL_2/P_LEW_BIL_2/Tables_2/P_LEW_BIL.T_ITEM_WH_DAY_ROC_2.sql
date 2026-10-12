/*** MSC-WARNING - MSCEWI2015 - SET TABLE FUNCTIONALITY NOT SUPPORTED ***/
CREATE TABLE P_LEW_BIL.T_ITEM_WH_DAY_ROC_2 (
client_id SMALLINT NOT NULL,
loc_sid INTEGER NOT NULL,
item_sid INTEGER NOT NULL,
stock_slot_fg BYTEINT NOT NULL,
stock_case_size_fg BYTEINT NOT NULL,
qty_piece_five_weeks_fg BYTEINT NOT NULL,
qty_piece_vs_case_size_fg BYTEINT NOT NULL,
qty_piece_stc_wh DECIMAL(18,5) NOT NULL,
qty_total_goodsout_avg_35_days DECIMAL(18,5) NOT NULL,
dwh_cal_dt DATE NOT NULL,
dwh_created TIMESTAMP(6) NOT NULL,
price_net DECIMAL(18,5),
UNIQUE (client_id ,loc_sid ,item_sid ,dwh_cal_dt)
)
/*** MSC-WARNING - MSCEWI2008 - PERFORMANCE REVIEW - CLUSTER BY ***/
/*CLUSTER BY(RANGE_N(dwh_cal_dt BETWEEN '2010-01-01' AND '2030-12-31' EACH INTERVAL '1 day' ,
NO RANGE), RANGE_N(client_id BETWEEN 1 AND 40 EACH 1 ,
NO RANGE))*/;


