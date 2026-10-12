 CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_FTM_TURNOVER_2(
      CLIENT_ID
    , COUNTRY_CODE
    , DAT_FORMDATE
    , CY_WEEK
    , STORE_ID
    , ORIG_STORE_NR
	  , ITEM_ID
    , ORIG_ITEM_NR
    , ITEMGROUP_INT_ID
    , SUBITEMGROUP_ID
    , ITEM_TYPE
    , SALES_NET_VAL
    , SALES_PIECES_EJR
    , BUYING_VAL
    , SALES_BASED_MARGIN
    , SALES_BASED_MARGIN_PCT
) AS
/*
#----------------------------------------------------------------------------
# 22-08-2024 SNIK1809 - NEW setup
#----------------------------------------------------------------------------
*/
SELECT
      CLIENT_ID
    , COUNTRY_CODE
    , DAT_FORMDATE
    , CY_WEEK
    , STORE_ID
    , ORIG_STORE_NR
	  , ITEM_ID
    , ORIG_ITEM_NR
    , ITEMGROUP_INT_ID
    , SUBITEMGROUP_ID
    , ITEM_TYPE
    , SALES_NET_VAL
    , SALES_PIECES_EJR
    , BUYING_VAL
    , SALES_BASED_MARGIN
    , SALES_BASED_MARGIN_PCT
FROM P_LEW_MART_ANALYTICS.V_FTM_TURNOVER_2;