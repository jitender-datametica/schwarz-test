/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_KFL_BRAND
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_kfl_brand (client_id, kfl_brand_sid, kfl_brand_name, brand_type_cd,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 kfl_brand_sid,
 kfl_brand_name,
 brand_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_kfl_brand;