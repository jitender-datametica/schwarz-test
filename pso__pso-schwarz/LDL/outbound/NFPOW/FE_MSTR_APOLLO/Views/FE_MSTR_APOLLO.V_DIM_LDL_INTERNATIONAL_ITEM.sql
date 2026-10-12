/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_INTERNATIONAL_ITEM
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  13.06.2023    Aparna Rayanki           Added Supplier attributes 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_ldl_international_item (ldl_item_ian_nr, ldl_parent_item_ian_nr,
nfpo_item_sid, nfpo_item_name, nfpo_pillar_sid, nfpo_pillar_name, nfpo_main_pillar_cd, nfpo_main_pillar_name,
nfpo_item_fam_grp_sid, nfpo_item_fam_grp_nr, nfpo_item_fam_grp_name, nfpo_ldl_brand_sid, nfpo_ldl_brand_nr,
nfpo_ldl_brand_name, nfpo_brand_type_name, nfpo_brand_type_cd, item_origin_type_cd, nfpo_sup_sid, nfpo_sup_nr,
nfpo_sup_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT ldl_item_ian_nr,
 ldl_parent_item_ian_nr,
 nfpo_item_sid,
 nfpo_item_name,
 nfpo_pillar_sid,
 nfpo_pillar_name,
 nfpo_main_pillar_cd,
 nfpo_main_pillar_name,
 nfpo_item_fam_grp_sid,
 nfpo_item_fam_grp_nr,
 nfpo_item_fam_grp_name,
 nfpo_ldl_brand_sid,
 nfpo_ldl_brand_nr,
 nfpo_ldl_brand_name,
 nfpo_brand_type_name,
 nfpo_brand_type_cd,
 item_origin_type_cd,
 nfpo_sup_sid,
 nfpo_sup_nr,
 nfpo_sup_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_tmsp
FROM nfpow_core.t_dim_ldl_international_item AS MAIN;