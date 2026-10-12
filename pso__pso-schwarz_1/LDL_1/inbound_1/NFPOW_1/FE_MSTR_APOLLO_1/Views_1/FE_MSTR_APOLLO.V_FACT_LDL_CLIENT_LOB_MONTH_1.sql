/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_CLIENT_LOB_MONTH_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.05.2023    Aparna Rayanki           PDM changes to column names
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_FACT_LDL_CLIENT_LOB_MONTH_1 
(
      LDL_CLIENT_ID
    , LOB_CD
    , CAL_MONTH
    , CAL_YEAR
    , CURR_CD
    , LDL_TOTAL_ADJUST_SALES_NET_VAL
    , LDL_PREV_1Y_TOTAL_ADJUST_SALES_NET_VAL
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LDL_CLIENT_ID
    , main.LOB_CD
    , main.CAL_MONTH
    , main.CAL_YEAR
    , main.CURR_CD
    , main.LDL_TOTAL_ADJUST_SALES_NET_VAL
    , main.LDL_PREV_1Y_TOTAL_ADJUST_SALES_NET_VAL
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_FACT_LDL_CLIENT_LOB_MONTH_1 main
;