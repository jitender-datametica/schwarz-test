/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_CALENDAR_MONTH_1
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_CALENDAR_MONTH_1 
(
      CAL_MONTH
    , LDL_CAL_MONTH_NAME
    , CAL_YEAR
    , MONTH_OF_CAL_YEAR
    , PREV_1Y_CAL_MONTH
    , CAL_MONTH_OFFSET
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.CAL_MONTH
    , main.LDL_CAL_MONTH_NAME
    , main.CAL_YEAR
    , main.MONTH_OF_CAL_YEAR
    , main.PREV_1Y_CAL_MONTH
    , main.CAL_MONTH_OFFSET
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_CALENDAR_MONTH_1 main
;