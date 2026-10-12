/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_CLIENT_ITEM_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  08.08.2024    Ulrich Meister           KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD added
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_FACT_LDL_CLIENT_ITEM_DAY 
(
      LOB_CD
    , LDL_CLIENT_ID
    , LDL_ITEM_SID
    , CAL_DT
    , CURR_CD
    , KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
    , LDL_RCV_QTY
    , LDL_BUYING_RCV_NET_VAL
    , LDL_RETAIL_RCV_NET_VAL
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LOB_CD
    , main.LDL_CLIENT_ID
    , main.LDL_ITEM_SID
    , main.CAL_DT
    , main.CURR_CD
    , main.KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
    , main.LDL_RCV_QTY
    , main.LDL_BUYING_RCV_NET_VAL
    , main.LDL_RETAIL_RCV_NET_VAL
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_FACT_LDL_CLIENT_ITEM_DAY main
;