CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_financial_order_debt_2 AS SELECT cust_order_install_nr
 ,
 debt_collection_item_nr,
 IFNULL(cust_sid, -1) AS cust_sid,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd,
  CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
 debt_collection_request_local_val,
 debt_collection_paid_local_val
FROM ldl_dig_lec_share.v_fact_customer_financial_order_debt_2
WHERE dwh_valid_fg;