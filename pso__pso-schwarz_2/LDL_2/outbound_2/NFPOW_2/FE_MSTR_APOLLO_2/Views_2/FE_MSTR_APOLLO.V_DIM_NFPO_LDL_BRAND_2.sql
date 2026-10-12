/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_NFPO_LDL_BRAND_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_nfpo_ldl_brand_2 (nfpo_ldl_brand_sid, nfpo_ldl_brand_nr,
nfpo_ldl_brand_name, nfpo_brand_type_cd, nfpo_brand_type_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS
SELECT *
FROM nfpow_core.t_dim_nfpo_ldl_brand_2 AS MAIN;