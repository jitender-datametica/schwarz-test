CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_purchase_organisation_type (prod_purch_org_type_cd,
prod_purch_org_type_descr) AS SELECT prod_purch_org_type_cd,
 prod_purch_org_type_descr
FROM ldl_dig_lec_share.v_dim_product_purchase_organisation_type
UNION ALL
SELECT '-1' AS prod_purch_org_type_cd,
 '' AS prod_purch_org_type_descr;