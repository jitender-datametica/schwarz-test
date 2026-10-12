CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_organisation_type_1 (cust_org_type_cd,
cust_org_type_descr) AS SELECT cust_org_type_cd,
 cust_org_type_descr
FROM ldl_dig_lec_share.v_dim_customer_organisation_type_1
UNION ALL
SELECT '-1',
 '';