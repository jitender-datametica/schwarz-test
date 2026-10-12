/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_FACT_LDL_STORE_ITEM_ADVERTISE_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Aparna Rayanki           Initial Version
#  1.1  13.06.2023    Aparna Rayanki           Added KFL sales 7 qty metric
#  1.2  05.07.2023    Aparna Rayanki           Added KFL stock metrics
#  1.3  08.08.2024    Ulrich Meister           added KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_FACT_LDL_STORE_ITEM_ADVERTISE_DAY 
(
      LOB_CD
    , LDL_STORE_SID
    , LDL_ITEM_SID
    , ADV_DT
    , LDL_CLIENT_ID
    , CURR_CD
    , KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
    , LDL_ADV_STOCK_QTY
    , KFL_ADV_STOCK_QTY
    , LDL_ADJUST_ADV_SALES_1_QTY
    , LDL_ADJUST_ADV_SALES_3_QTY
    , LDL_ADJUST_ADV_SALES_7_QTY
    , KFL_ADJUST_ADV_SALES_7_QTY
    , LDL_ADJUST_ADV_SALES_17_QTY
    , LDL_ADJUST_ADV_SALES_17_NET_VAL
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.LOB_CD
    , main.LDL_STORE_SID
    , main.LDL_ITEM_SID
    , main.ADV_DT
    , main.LDL_CLIENT_ID
    , main.CURR_CD
    , main.KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
    , main.LDL_ADV_STOCK_QTY
    , main.KFL_ADV_STOCK_QTY
    , main.LDL_ADJUST_ADV_SALES_1_QTY
    , main.LDL_ADJUST_ADV_SALES_3_QTY
    , main.LDL_ADJUST_ADV_SALES_7_QTY
    , main.KFL_ADJUST_ADV_SALES_7_QTY
    , main.LDL_ADJUST_ADV_SALES_17_QTY
    , main.LDL_ADJUST_ADV_SALES_17_NET_VAL
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_FACT_LDL_STORE_ITEM_ADVERTISE_DAY main
;