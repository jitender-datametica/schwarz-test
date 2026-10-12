/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_MDM_ITEM_CLIENT_ORDER_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_mdm_item_client_order_2 (client_id, mdm_item_sid, client_id_order,
client_cd, client_block_id_order, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_sid,
 client_id_order,
 client_cd,
 client_block_id_order,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core_ac.v_mdm_item_client_order_2;