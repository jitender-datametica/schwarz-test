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

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_LDL_INTERNATIONAL_ITEM 
(
      LDL_ITEM_IAN_NR
    , LDL_PARENT_ITEM_IAN_NR
    , NFPO_ITEM_SID
    , NFPO_ITEM_NAME
    , NFPO_PILLAR_SID
    , NFPO_PILLAR_NAME
    , NFPO_MAIN_PILLAR_CD
    , NFPO_MAIN_PILLAR_NAME
    , NFPO_ITEM_FAM_GRP_SID
    , NFPO_ITEM_FAM_GRP_NR
    , NFPO_ITEM_FAM_GRP_NAME
    , NFPO_LDL_BRAND_SID
    , NFPO_LDL_BRAND_NR
    , NFPO_LDL_BRAND_NAME
    , NFPO_BRAND_TYPE_NAME
    , NFPO_BRAND_TYPE_CD
    , ITEM_ORIGIN_TYPE_CD
    , NFPO_SUP_SID
	, NFPO_SUP_NR
	, NFPO_SUP_NAME	
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LDL_ITEM_IAN_NR
    , main.LDL_PARENT_ITEM_IAN_NR
    , main.NFPO_ITEM_SID
    , main.NFPO_ITEM_NAME
    , main.NFPO_PILLAR_SID
    , main.NFPO_PILLAR_NAME
    , main.NFPO_MAIN_PILLAR_CD
    , main.NFPO_MAIN_PILLAR_NAME
    , main.NFPO_ITEM_FAM_GRP_SID
    , main.NFPO_ITEM_FAM_GRP_NR
    , main.NFPO_ITEM_FAM_GRP_NAME
    , main.NFPO_LDL_BRAND_SID
    , main.NFPO_LDL_BRAND_NR
    , main.NFPO_LDL_BRAND_NAME
    , main.NFPO_BRAND_TYPE_NAME
    , main.NFPO_BRAND_TYPE_CD
    , main.ITEM_ORIGIN_TYPE_CD
    , main.NFPO_SUP_SID
	, main.NFPO_SUP_NR
	, main.NFPO_SUP_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_LDL_INTERNATIONAL_ITEM main
;