/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_LDL_CURRENCY_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_LDL_CURRENCY_1 
(
      CURR_CD
    , LDL_CURR_NAME
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.CURR_CD
    , main.LDL_CURR_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_LDL_CURRENCY_1 main
;