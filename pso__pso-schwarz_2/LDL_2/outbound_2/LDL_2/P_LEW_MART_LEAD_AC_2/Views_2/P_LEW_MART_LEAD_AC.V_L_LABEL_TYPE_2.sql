/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_TYPE_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.01.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_l_label_type_2 (electronic_price_label_type_cd_fe) AS SELECT DISTINCT
 electronic_price_label_type_cd_fe
FROM ldl_p_lew_mart_lead_ac.v_price_label_2;