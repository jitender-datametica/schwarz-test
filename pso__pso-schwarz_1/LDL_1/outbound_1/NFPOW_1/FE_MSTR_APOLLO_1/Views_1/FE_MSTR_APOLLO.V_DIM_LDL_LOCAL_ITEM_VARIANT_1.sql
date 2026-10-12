/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_LOCAL_ITEM_VARIANT_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_ldl_local_item_variant_1 (lob_cd, ldl_item_sid, ldl_client_id,
ldl_item_nr, case_size_qty, active_from_dt, ldl_item_ian_nr, ldl_brand_list_type_id, ldl_list_type_id, ldl_brand_name,
ldl_item_fam_grp_nr, ldl_sub_item_grp_id, ldl_item_name, item_origin_type_cd, dwh_created_tmsp, dwh_updated_tmsp,
dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_ldl_local_item_variant_1 AS MAIN;