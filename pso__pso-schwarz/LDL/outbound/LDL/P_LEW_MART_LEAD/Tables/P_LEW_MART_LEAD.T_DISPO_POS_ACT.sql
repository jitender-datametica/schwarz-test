/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.T_DISPO_POS_ACT
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Add some columns
#  1.2  06.03.2023    Bachmann, Torsten        added reason_cd from T_REPLENISH_ORDER_WH_RECORD_POS_CHANGELOG
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_dispo_pos_act (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
sup_sid BIGNUMERIC(38,0),
order_record_id STRING(20) COLLATE 'und:ci' NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
order_pos_version_nr BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
deleted_fg INTEGER,
delivery_dt DATE,
order_status_cd BIGNUMERIC(38,0),
part_fg BIGNUMERIC(38,0) NOT NULL,
order_qty_type_cd BIGNUMERIC(38,0) NOT NULL,
order_qty NUMERIC(18,5),
order_delivered_case_qty NUMERIC(18,5),
case_factor BIGNUMERIC(38,0),
real_case_size NUMERIC(9,5),
init_order_qty_type_cd BIGNUMERIC(38,0),
init_order_qty NUMERIC(18,5),
init_case_factor BIGNUMERIC(38,0),
delta_order_case_qty BIGNUMERIC(38,5),
order_status_cd_override BIGNUMERIC(38,0)
OPTIONS(description='Override status_cd = 9, in case there are receiving or it is not the last cancelled line'),
init_delivery_dt DATE OPTIONS(description='initial delivery date, retrieved from replenish_order_wh_record (Head)'),
min_rcv_dt DATE
OPTIONS(description='MIN receiveing date in case there are more than one receivings booked on the same order'),
max_rcv_dt DATE
OPTIONS(description='MAX receiveing date in case there are more than one receivings booked on the same order'),
qty_case_rcv_ontime NUMERIC(18,4) OPTIONS(description='qty which was delivered/recieved on planned delivery_dt'),
qty_case_rcv_ahead_schedule NUMERIC(18,4)
OPTIONS(description='qty which was delivered/recieved before planned delivery_dt'),
qty_case_rcv_delay_1_day NUMERIC(18,4) OPTIONS(description='qty which was delivered/recieved one day after delivery_dt'),
qty_case_rcv_delay_2_days NUMERIC(18,4)
OPTIONS(description='qty which was delivered/recieved two days after delivery_dt'),
qty_case_rcv_delay_3_days NUMERIC(18,4)
OPTIONS(description='qty which was delivered/recieved three days after delivery_dt'),
qty_case_rcv_delay_ge_4_days NUMERIC(18,4)
OPTIONS(description='qty which was delivered/recieved more than 3 days after delivery_dt'),
cnt_days_delayed BIGNUMERIC(38)
OPTIONS(description='Number of days delayed, in case there are more than one receivings booked on the same order, we use MAX(rcv_dt)'),
cnt_rcv BIGNUMERIC(38),
mapping_pos_nr BIGNUMERIC(38,0),
orig_receipt_id_rcv STRING(100) COLLATE 'und:ci',
order_pos_created_tmsp DATETIME,
order_pos_updated_tmsp DATETIME,
delivery_tmsp DATETIME,
all_reason_cd STRING(300),
first_reason_cd BIGNUMERIC(38,0),
last_reason_cd BIGNUMERIC(38,0),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) OPTIONS(description='Actual Dispo data with receiving data, limited for last 3 years');