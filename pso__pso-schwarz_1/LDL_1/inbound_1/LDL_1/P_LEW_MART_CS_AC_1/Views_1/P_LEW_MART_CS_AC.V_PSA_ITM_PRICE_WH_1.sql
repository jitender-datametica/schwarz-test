/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_PSA_ITM_PRICE_WH_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_PSA_ITM_PRICE_WH_1
/*
#DescStart#
#$Revision: 13547 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , item_id
    , wh_id
    , calendar_dt
    , price_retail
    , price_retail_net
    , price_retail_eur
    , price_retail_net_eur
)
AS
SELECT
client_id,
item_id,
wh_id,
calendar_dt,
price_retail,
price_retail_net,
price_retail_eur,
price_retail_net_eur
FROM p_lew_mart_cs.v_psa_itm_price_wh_1
;


