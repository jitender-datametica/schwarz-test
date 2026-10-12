/*
#----------------------------------------------------------------------------
# @ Schwarz IT KG - Enterprise Reporting VT-WG [LDL - DIV]
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_ITEMSALE_DAY_DELTA_PERSIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  23.11.2022    Jana Mildorf      User Story 398511
#  1.1  07.03.2022    Jana Mildorf      User Story 448812
   1.2  24.07.2023    Olga Becker       User Story 499314
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_wfm.t_itemsale_day_delta_persist_2 (
client_id BIGNUMERIC(38,0),
store BIGNUMERIC(38,0),
item_2 BIGNUMERIC(38,0),
receiptdate DATE,
sum_qty_weight NUMERIC(32,5),
sum_qty_piece NUMERIC(31,5),
sum_turnover_net NUMERIC(31,5),
timelastsold TIME,
discount_value_net NUMERIC(31,5),
discount_pieces NUMERIC(30,5),
discount_turnover_net NUMERIC(31,5),
discount_weight_piece NUMERIC(32,5),
discount_pieces_txj NUMERIC(30,5),
discount_pieces_cashpoint NUMERIC(30,5),
discount_pieces_sfo BIGNUMERIC(38,10),
discount_units NUMERIC(30,5),
discount_lw NUMERIC(30,5),
discount_ejr NUMERIC(30,5),
load_id STRING(16777216),
last_persist_tmsp DATETIME DEFAULT CAST(CURRENT_TIMESTAMP() AS DATETIME)
) CLUSTER BY receiptdate;