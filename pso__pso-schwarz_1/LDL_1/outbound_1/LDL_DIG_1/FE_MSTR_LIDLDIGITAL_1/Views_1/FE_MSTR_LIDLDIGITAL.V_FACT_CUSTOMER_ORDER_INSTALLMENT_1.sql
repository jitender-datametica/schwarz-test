CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_customer_order_installment_1 AS SELECT CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
  CASE
  WHEN cust_order_install_nr = ''
  THEN '-1'
  ELSE IFNULL(cust_order_install_nr, '-1')
  END AS cust_order_install_nr,
  CASE
  WHEN cust_order_install_pos_nr = ''
  THEN '-1'
  ELSE IFNULL(cust_order_install_pos_nr, '-1')
  END AS cust_order_install_pos_nr,
  CASE
  WHEN cust_order_install_part_pos_nr = ''
  THEN '-1'
  ELSE IFNULL(cust_order_install_part_pos_nr, '-1')
  END AS cust_order_install_part_pos_nr,
  CASE
  WHEN cust_order_install_part_rep_pos_nr = ''
  THEN '-1'
  ELSE IFNULL(cust_order_install_part_rep_pos_nr, '-1')
  END AS cust_order_install_part_rep_pos_nr,
 fin_order_create_dt,
 IFNULL(cust_order_sid, -1) AS cust_order_sid,
 IFNULL(cust_sid, -1) AS cust_sid,
  CASE
  WHEN install_type_cd = ''
  THEN '-1'
  ELSE IFNULL(install_type_cd, '-1')
  END AS install_type_cd,
 install_part_pos_due_dt,
 amt_paid_local_val,
  CASE
  WHEN cust_paym_method_cd = ''
  THEN '-1'
  ELSE IFNULL(cust_paym_method_cd, '-1')
  END AS cust_paym_method_cd,
 is_settl_fg,
  CASE
  WHEN paym_settl_type_cd = ''
  THEN '-1'
  ELSE IFNULL(paym_settl_type_cd, '-1')
  END AS paym_settl_type_cd,
 debt_collection_start_dt,
 IFNULL(install_warn_status_cd, -1) AS install_warn_status_cd,
 cust_order_nr,
 paym_request_dt,
 amt_dunned_local_val,
 is_dun_notice_reversed_fg,
 IFNULL(debt_collection_item_nr, -1) AS debt_collection_item_nr,
  CASE
  WHEN curr_cd = ''
  THEN '-1'
  ELSE IFNULL(curr_cd, '-1')
  END AS curr_cd
FROM ldl_dig_lec_share.v_fact_customer_order_installment_1
WHERE dwh_valid_fg;