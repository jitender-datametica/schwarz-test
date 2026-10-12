/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_NFPO_ITEM_FAMILY_GROUP
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW nfpow_fe_mstr_apollo.v_dim_nfpo_item_family_group (nfpo_item_fam_grp_sid, nfpo_item_fam_grp_nr,
nfpo_item_fam_grp_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_tmsp) AS SELECT nfpo_item_fam_grp_sid,
 nfpo_item_fam_grp_nr,
 nfpo_item_fam_grp_name,
 dwh_created_tmsp,
 dwh_updated_tmsp,
 dwh_src_tmsp
FROM nfpow_core.t_dim_nfpo_item_family_group AS MAIN;