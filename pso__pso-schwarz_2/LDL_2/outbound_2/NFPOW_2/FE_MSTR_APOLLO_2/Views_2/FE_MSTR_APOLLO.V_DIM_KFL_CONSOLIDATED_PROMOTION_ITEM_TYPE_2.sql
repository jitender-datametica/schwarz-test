/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Ulrich Meister           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_kfl_consolidated_promotion_item_type_2 (kfl_consolidated_promo_item_type_cd
, kfl_consolidated_promo_item_type_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT *
FROM nfpow_core.t_dim_kfl_consolidated_promotion_item_type_2 AS MAIN;