CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_ref_pricegrp (client_id, position_article_sales_rep, pricegroup_id,
pricegroup_desc, article_sales_rep_desc, dat_valid_from, dat_valid_until, load_id) AS SELECT client_id,
 position_article_sales_rep,
 pricegroup_id,
 pricegroup_desc,
 article_sales_rep_desc,
 dat_valid_from,
 dat_valid_until,
 load_id
FROM ldl_p_lew_core.t_wawi_ref_pricegrp;