/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_STORE_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_LDL_STORE_1 
(
      LOB_CD
    , LDL_STORE_SID
    , LDL_CLIENT_ID
    , LDL_STORE_NR
    , LDL_STORE_NAME
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LOB_CD
    , main.LDL_STORE_SID
    , main.LDL_CLIENT_ID
    , main.LDL_STORE_NR
    , main.LDL_STORE_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_LDL_STORE_1 main
;