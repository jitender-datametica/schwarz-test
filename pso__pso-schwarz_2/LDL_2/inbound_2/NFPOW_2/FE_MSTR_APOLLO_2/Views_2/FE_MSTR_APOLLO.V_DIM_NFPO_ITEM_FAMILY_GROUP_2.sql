/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_NFPO_ITEM_FAMILY_GROUP_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_NFPO_ITEM_FAMILY_GROUP_2 
(
      NFPO_ITEM_FAM_GRP_SID
    , NFPO_ITEM_FAM_GRP_NR
    , NFPO_ITEM_FAM_GRP_NAME
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.NFPO_ITEM_FAM_GRP_SID
    , main.NFPO_ITEM_FAM_GRP_NR
    , main.NFPO_ITEM_FAM_GRP_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_NFPO_ITEM_FAMILY_GROUP_2 main
;