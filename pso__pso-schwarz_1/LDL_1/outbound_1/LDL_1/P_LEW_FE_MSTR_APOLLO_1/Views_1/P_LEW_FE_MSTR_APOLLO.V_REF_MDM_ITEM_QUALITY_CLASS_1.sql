/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_FE_MSTR_APOLLO.V_REF_MDM_ITEM_QUALITY_CLASS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.01.2022    Malinowski, Michal           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_apollo.v_ref_mdm_item_quality_class_1 (item_quality_class_cd,
item_quality_class_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT *
FROM ldl_p_lew_core_ac.v_ref_mdm_item_quality_class_1;