/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_PRICE_LABEL_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard 
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  07.02.2023    Simeon Nikolaev                     Removed CLIENT_ID,DWH_LOAD_ID,DWH_CREATED,DWH_UPDATED
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_price_label_2 (price_label_sid, price_label_nr,
electronic_price_label_type_cd, electronic_price_label_type_cd_fe, price_label_producer_name) AS SELECT *
FROM ldl_p_lew_mart_lead.v_price_label_2;