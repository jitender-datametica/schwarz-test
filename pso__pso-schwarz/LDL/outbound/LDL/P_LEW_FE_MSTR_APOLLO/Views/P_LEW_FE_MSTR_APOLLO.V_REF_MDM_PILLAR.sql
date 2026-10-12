/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_REF_MDM_PILLAR
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_ref_mdm_pillar (mdm_pillar_sid, mdm_pillar_name, dwh_load_id,
dwh_created, dwh_updated) AS SELECT mdm_pillar_sid,
 mdm_pillar_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_mdm_pillar;