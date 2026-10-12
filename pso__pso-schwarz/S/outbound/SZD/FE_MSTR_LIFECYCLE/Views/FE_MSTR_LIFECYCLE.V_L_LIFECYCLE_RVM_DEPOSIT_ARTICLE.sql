CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_rvm_deposit_article AS SELECT item_sid,
 item_gtin,
 lob_cd,
 manufacturer_sid,
 unitsize_descr,
 item_name,
 item_container_type_cd,
 item_package_type_descr,
 first_distributor_name,
 country_pol_cd
FROM szd_core.t_dim_deposit_article;