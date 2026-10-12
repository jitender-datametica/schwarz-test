/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_AGG_PRICE_LABEL_REPAIR_STATE_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  06.02.2024    Simeon Nikolaev					  Removed unused columns
#  1.3  13.02.2024    Simeon Nikolaev					  CLIENT/WH/INTEGER AGGREGATIONS
#  1.4  27.12.2023    Simeon Nikolaev                     Included 'PRICE_LABEL_REPAIR_ORIGIN_NAME'/'DEFECT_TXT'
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_agg_price_label_repair_state_2 (client_id, move_to_store_id, wh_id,
aspect_id, price_label_sid, wh_label_cnt, client_label_cnt, int_label_cnt, price_label_producer_name,
electronic_price_label_type_cd, electronic_price_label_type_cd_fe, dat_formdate, repair_start_dt, repair_end_dt,
price_label_warranty_status_cd, price_label_repair_result_cd, price_label_repair_origin_name, defect_txt, defect_count,
wh_defect_count, client_defect_count, int_defect_count, notdefect_count, wh_notdefect_count, client_notdefect_count,
int_notdefect_count, warranty_count, wh_warranty_count, client_warranty_count, int_warranty_count, usage_diff,
wh_usage_diff, client_usage_diff, int_usage_diff, net_price, defectprice, defectprice_cur, wh_defectprice_cur,
client_defectprice_cur, int_defectprice_cur, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_lead.v_agg_price_label_repair_state_2;