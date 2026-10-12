CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_loyalty_classification (cust_loyalty_classification_cd
, cust_loyalty_classification_descr) AS SELECT cust_loyalty_classification_cd,
 cust_loyalty_classification_descr
FROM ldl_dig_lec_share.v_dim_customer_loyalty_classification
WHERE cust_loyalty_classification_cd NOT IN ('0', '1', '2', '3')
UNION DISTINCT
SELECT '-1',
 '';