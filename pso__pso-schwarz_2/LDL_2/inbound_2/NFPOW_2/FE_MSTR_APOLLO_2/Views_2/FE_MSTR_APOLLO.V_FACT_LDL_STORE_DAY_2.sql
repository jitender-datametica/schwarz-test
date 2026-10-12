/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_STORE_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.05.2023    Aparna Rayanki           PDM changes to column names
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_FACT_LDL_STORE_DAY_2 
(
      LOB_CD
    , LDL_STORE_SID
    , CAL_DT
    , LDL_CLIENT_ID
    , CURR_CD
    , LDL_TOTAL_ADJUST_SALES_NET_VAL
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LOB_CD
    , main.LDL_STORE_SID
    , main.CAL_DT
    , main.LDL_CLIENT_ID
    , main.CURR_CD
    , main.LDL_TOTAL_ADJUST_SALES_NET_VAL
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_FACT_LDL_STORE_DAY_2 main
;