/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.v_brand
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_brand (client_id, brand_sid, src_brand_cd, brand_name, brand_type_cd,
dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_brand;