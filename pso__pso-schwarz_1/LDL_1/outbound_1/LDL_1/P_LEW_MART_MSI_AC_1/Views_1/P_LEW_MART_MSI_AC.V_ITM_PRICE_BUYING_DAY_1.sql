/* #DescStart#
#$Revision: 6295 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_price_buying_day_1 (client_id, item_id, dat_calendar, wh_id,
supplier_id, price_buying, price_buying_sp_cond, orig_item_nr, currency_iso_cd) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_price_buying_day_1;