/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for _LEW_MART_LEAD.T_DISPO_POS_HIST_2
#----------------------------------------------------------------------------
# History:
#  1.0  20.09.2022    Bachmann, Torsten        Initial version for Liefertreue (Prototype)
#  1.1  27.09.2022    Bachmann, Torsten        Rename column
#  1.2  18.01.2023    Bachmann, Torsten        dwh_cal_dt added
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_dispo_pos_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid BIGNUMERIC(38,0) NOT NULL,
order_record_id STRING(20) COLLATE 'und:ci' NOT NULL,
item_sid BIGNUMERIC(38,0) NOT NULL,
order_pos_version_nr BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from DATE NOT NULL,
dwh_valid_to DATE,
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
order_pos_created_tmsp DATETIME,
order_pos_updated_tmsp DATETIME,
delivery_tmsp DATETIME,
dwh_cal_dt DATE,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
) OPTIONS(description='Historized version of T_REPLENISH_ORDER_WH_RECORD_POS_2 with addional columns');