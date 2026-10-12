/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_CLIENT_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_LDL_CLIENT_1 
(
      LDL_CLIENT_ID
    , LDL_CLIENT_CD
    , LDL_CLIENT_NAME
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LDL_CLIENT_ID
    , main.LDL_CLIENT_CD
    , main.LDL_CLIENT_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_LDL_CLIENT_1 main
;