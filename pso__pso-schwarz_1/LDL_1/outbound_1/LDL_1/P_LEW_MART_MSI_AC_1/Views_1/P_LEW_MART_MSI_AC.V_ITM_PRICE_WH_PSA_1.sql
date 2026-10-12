/* #DescStart#
#$Revision: 7752 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_price_wh_psa_1 (client_id, item_id, wh_id, dat_calendar, price_retail,
price_retail_net, price_retail_eur, price_retail_net_eur) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_price_wh_psa_1;