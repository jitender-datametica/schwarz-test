/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_APOLLO.V_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE_2
#----------------------------------------------------------------------------
# History:
#  1.0  11.04.2023    Ulrich Meister           Initial Version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW FE_MSTR_APOLLO.V_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE_2
(
      KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
    , KFL_CONSOLIDATED_PROMO_ITEM_TYPE_NAME
    , DWH_CREATED_TMSP
    , DWH_UPDATED_TMSP
    , DWH_SRC_TMSP
)
AS SELECT
      main.KFL_CONSOLIDATED_PROMO_ITEM_TYPE_CD
    , main.KFL_CONSOLIDATED_PROMO_ITEM_TYPE_NAME
    , main.DWH_CREATED_TMSP
    , main.DWH_UPDATED_TMSP
    , main.DWH_SRC_TMSP
FROM CORE.T_DIM_KFL_CONSOLIDATED_PROMOTION_ITEM_TYPE_2 main
;