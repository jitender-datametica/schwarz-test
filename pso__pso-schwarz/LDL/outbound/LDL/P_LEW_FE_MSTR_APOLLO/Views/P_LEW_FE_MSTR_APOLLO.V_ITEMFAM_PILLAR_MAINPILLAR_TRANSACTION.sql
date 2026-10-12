/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_ITEMFAM_PILLAR_MAINPILLAR_TRANSACTION
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_itemfam_pillar_mainpillar_transaction (src_familygrp_cd,
item_fam_grp_name, pillar_id, pillar_name, main_pillar_id, main_pillar_name) AS SELECT src_familygrp_cd,
 item_fam_grp_name,
 pillar_id,
 pillar_name,
 main_pillar_id,
 main_pillar_name
FROM ldl_p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction;