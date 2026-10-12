/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_PRODUCER
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.01.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_l_label_producer (price_label_producer_name, dwh_load_id, dwh_created,
dwh_updated) AS SELECT *
FROM ldl_p_lew_mart_lead.v_ref_price_label_producer;