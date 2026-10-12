/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_CLIENT_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_client_1 (client_id, src_client_id, src_country_lidl_cd,
src_country_cbx_cd, client_name, country_sid, country_cd, curr_sid, curr_cd, client_online_fg, dwh_load_id, dwh_created
, dwh_updated, lob_cd) AS SELECT client_id,
 src_client_id,
 src_country_lidl_cd,
 src_country_cbx_cd,
 client_name,
 country_sid,
 country_cd,
 curr_sid,
 curr_cd,
 client_online_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 lob_cd
FROM ldl_p_lew_core_ac.v_client_1;