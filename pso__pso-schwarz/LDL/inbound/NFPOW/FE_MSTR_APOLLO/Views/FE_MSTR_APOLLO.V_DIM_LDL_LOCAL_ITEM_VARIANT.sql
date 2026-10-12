/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_LOCAL_ITEM_VARIANT
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_LDL_LOCAL_ITEM_VARIANT 
(
      LOB_CD
    , LDL_ITEM_SID
    , LDL_CLIENT_ID
    , LDL_ITEM_NR
    , CASE_SIZE_QTY
    , ACTIVE_FROM_DT
    , LDL_ITEM_IAN_NR
    , LDL_BRAND_LIST_TYPE_ID
    , LDL_LIST_TYPE_ID
    , LDL_BRAND_NAME
    , LDL_ITEM_FAM_GRP_NR
    , LDL_SUB_ITEM_GRP_ID
    , LDL_ITEM_NAME
    , ITEM_ORIGIN_TYPE_CD
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LOB_CD
    , main.LDL_ITEM_SID
    , main.LDL_CLIENT_ID
    , main.LDL_ITEM_NR
    , main.CASE_SIZE_QTY
    , main.ACTIVE_FROM_DT
    , main.LDL_ITEM_IAN_NR
    , main.LDL_BRAND_LIST_TYPE_ID
    , main.LDL_LIST_TYPE_ID
    , main.LDL_BRAND_NAME
    , main.LDL_ITEM_FAM_GRP_NR
    , main.LDL_SUB_ITEM_GRP_ID
    , main.LDL_ITEM_NAME
    , main.ITEM_ORIGIN_TYPE_CD
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_LDL_LOCAL_ITEM_VARIANT main
;