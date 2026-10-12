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

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_NFPO_LDL_BRAND_2 
(
      NFPO_LDL_BRAND_SID
    , NFPO_LDL_BRAND_NR
    , NFPO_LDL_BRAND_NAME
    , NFPO_BRAND_TYPE_CD
    , NFPO_BRAND_TYPE_NAME
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.NFPO_LDL_BRAND_SID
    , main.NFPO_LDL_BRAND_NR
    , main.NFPO_LDL_BRAND_NAME
    , main.NFPO_BRAND_TYPE_CD
    , main.NFPO_BRAND_TYPE_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_NFPO_LDL_BRAND_2 main
;