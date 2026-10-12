/* #DescStart#
#$Revision: 7138 $, $LastChangedBy: umeister $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_aul_itm_sup_mth_price_1 (client_id, item_id, cy_month, wh_id, supplier_id,
price_buying, price_buying_sp_cond, currency_iso_cd, order_buying_list_cd, main_negot_cntry_cd, agg_co_negot_cntry_cd,
article_sales_rep_desc1, price_retail1, price_retail1_net, article_sales_rep_desc2, price_retail2, price_retail2_net,
article_sales_rep_desc3, price_retail3, price_retail3_net) AS SELECT *
FROM ldl_p_lew_mart_msi.v_aul_itm_sup_mth_price_1;