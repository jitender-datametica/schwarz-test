/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_PRICE_LABEL_STORE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard 
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  13.02.2024    Simeon Nikolaev					  RMA_LABEL - CLIENT/WH/INT AGGREGATION
#  1.3  04.06.2024    Simeon Nikolaev					  Adding materialized data
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_price_label_store_1 (client_id, price_label_sid, dat_formdate,
move_to_store_id, wh_id, aspect_id, electronic_price_label_type_cd, electronic_price_label_type_cd_fe,
price_label_producer_name, damaged_fg, price_label_create_tmsp, rma_label, dwh_valid_from, dwh_valid_to, wh_rma_label,
client_rma_label, int_rma_label, wh_label_cnt, client_label_cnt, int_label_cnt) AS SELECT client_id,
 price_label_sid,
 dat_formdate,
 move_to_store_id,
 wh_id,
 aspect_id,
 electronic_price_label_type_cd,
 electronic_price_label_type_cd_fe,
 price_label_producer_name,
 damaged_fg,
 price_label_create_tmsp,
 rma_label,
 dwh_valid_from,
 dwh_valid_to,
 wh_rma_label,
 client_rma_label,
 int_rma_label,
 wh_label_cnt,
 client_label_cnt,
 int_label_cnt
FROM ldl_p_lew_mart_lead.t_price_label_store_1;