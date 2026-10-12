CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_customer_payment_method_1 (cust_paym_method_cd,
cust_paym_method_descr, is_secure_fg, cust_paym_method_short_name, cust_paym_method_name) AS SELECT cust_paym_method_cd
 ,
 cust_paym_method_descr,
 is_secure_fg,
 cust_paym_method_short_name,
 cust_paym_method_name
FROM ldl_dig_lec_share.v_dim_customer_payment_method_1
WHERE cust_paym_method_descr <> ''
UNION ALL
SELECT '-1',
 '',
 FALSE,
 '',
 '';