/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_LOCAL_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_LDL_LOCAL_ITEM_1 
(
      LOB_CD
    , LDL_CLIENT_ID
    , LDL_ITEM_NR
    , ACTIVE_FROM_DT
    , LDL_ITEM_IAN_NR
    , ITEM_ORIGIN_TYPE_CD
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LOB_CD
    , main.LDL_CLIENT_ID
    , main.LDL_ITEM_NR
    , main.ACTIVE_FROM_DT
    , main.LDL_ITEM_IAN_NR
    , main.ITEM_ORIGIN_TYPE_CD
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_LDL_LOCAL_ITEM_1 main
;