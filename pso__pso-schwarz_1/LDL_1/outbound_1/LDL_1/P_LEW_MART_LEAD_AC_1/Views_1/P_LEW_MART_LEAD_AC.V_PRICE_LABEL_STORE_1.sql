/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_PRICE_LABEL_STORE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard 
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  13.02.2024    Simeon Nikolaev					  RMA_LABEL - CLIENT/WH/INTEGER AGGREGATION
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_price_label_store_1 (client_id, price_label_sid, dat_formdate,
move_to_store_id, wh_id, aspect_id, electronic_price_label_type_cd, electronic_price_label_type_cd_fe,
price_label_producer_name, damaged_fg, rma_label, dwh_valid_from, dwh_valid_to, wh_rma_label, client_rma_label,
int_rma_label, wh_label_cnt, client_label_cnt, int_label_cnt) AS SELECT client_id,
 price_label_sid,
 dat_formdate,
 move_to_store_id,
 wh_id,
 aspect_id,
 electronic_price_label_type_cd,
 electronic_price_label_type_cd_fe,
 price_label_producer_name,
 damaged_fg,
 rma_label,
 dwh_valid_from,
 dwh_valid_to,
 wh_rma_label,
 client_rma_label,
 int_rma_label,
 wh_label_cnt,
 client_label_cnt,
 int_label_cnt
FROM ldl_p_lew_mart_lead.v_price_label_store_1;