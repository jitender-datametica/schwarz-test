CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_ITM_PRICE_WH_PSA_1
/*
#DescStart#
#$Revision: 7752 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , item_id
    , wh_id
    , dat_calendar
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
dat_calendar,
price_retail,
price_retail_net,
price_retail_eur,
price_retail_net_eur
FROM p_lew_mart_msi.v_itm_price_wh_psa_1
;


