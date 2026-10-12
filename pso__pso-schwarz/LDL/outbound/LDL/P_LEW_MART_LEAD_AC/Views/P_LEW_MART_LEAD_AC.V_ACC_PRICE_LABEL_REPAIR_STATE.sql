/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_TYPE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  15.05.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard + q refresh
#  1.0  11.06.2024    Simeon Nikolaev           Aggregation metrics
#----------------------------------------------------------------------------------------------------------------
*/
/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_TYPE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  15.05.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard + q refresh
#  1.0  11.06.2024    Simeon Nikolaev           Aggregation metrics
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_acc_price_label_repair_state (client_id, move_to_store_id, wh_id,
aspect_id, price_label_producer_name, electronic_price_label_type_cd, electronic_price_label_type_cd_fe, dat_formdate,
repair_start_dt, repair_end_dt, price_label_warranty_status_cd, price_label_repair_result_cd,
price_label_repair_origin_name, defect_txt, net_price, defectprice, defectprice_cur, wh_defectprice_cur,
client_defectprice_cur, int_defectprice_cur, curr_iso_cd, price_label_sid, wh_label_cnt, client_label_cnt, int_label_cnt
, defect_count, wh_defect_count, client_defect_count, int_defect_count, notdefect_count, wh_notdefect_count,
client_notdefect_count, int_notdefect_count, warranty_count, wh_warranty_count, client_warranty_count,
int_warranty_count) AS SELECT *
FROM ldl_p_lew_mart_lead.v_acc_price_label_repair_state;