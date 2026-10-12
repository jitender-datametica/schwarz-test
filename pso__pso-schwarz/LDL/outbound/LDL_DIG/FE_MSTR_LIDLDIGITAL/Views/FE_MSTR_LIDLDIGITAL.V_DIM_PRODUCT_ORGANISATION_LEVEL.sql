CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_organisation_level AS SELECT prod_org_lvl_name,
 prod_org_lvl_descr
FROM ldl_dig_lec_share.v_dim_product_organisation_level
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;