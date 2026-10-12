CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_temp.v_mly_prot_wawi_product_2 (wawi_prod_sid, dwh_valid_from,
dwh_valid_to, wawi_country_cd, wawi_orig_item_nr, wawi_prod_descr) AS SELECT *
FROM ldl_data_production_fe_mstr_temp.t_mly_prot_wawi_product_2 AS main;