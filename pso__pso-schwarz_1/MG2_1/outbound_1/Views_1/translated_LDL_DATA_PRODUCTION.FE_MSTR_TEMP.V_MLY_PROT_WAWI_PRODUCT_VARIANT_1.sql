CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_temp.v_mly_prot_wawi_product_variant_1 (wawi_variant_sid,
dwh_valid_from, dwh_valid_to, wawi_country_cd, wawi_orig_item_nr, wawi_case_size, wawi_variant_descr, wawi_case_size_dec
, wawi_product_sid) AS SELECT wawi_variant_sid,
 dwh_valid_from,
 dwh_valid_to,
 wawi_country_cd,
 wawi_orig_item_nr,
 wawi_case_size,
 wawi_variant_descr,
 wawi_case_size_dec,
 wawi_prod_sid AS wawi_product_sid
FROM ldl_data_production_fe_mstr_temp.t_mly_prot_wawi_product_variant_1 AS main;


