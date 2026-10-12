CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_webshop_profit_loss_reason_1 AS SELECT CASE
  WHEN wshop_cd = ''
  THEN '-1'
  ELSE IFNULL(wshop_cd, '-1')
  END AS wshop_cd,
  CASE
  WHEN profit_loss_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_cd, '-1')
  END AS profit_loss_reason_cd,
 IFNULL(fin_acct_sid, -1) AS fin_acct_sid,
 IFNULL(reconcil_fin_acct_sid, -1) AS reconcil_fin_acct_sid,
 IFNULL(correction_fin_acct_sid, -1) AS correction_fin_acct_sid,
 depart_name,
  CASE
  WHEN profit_loss_reason_pos_group_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_pos_group_cd, '-1')
  END AS profit_loss_reason_pos_group_cd,
  CASE
  WHEN profit_loss_reason_mgmt_group_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_mgmt_group_cd, '-1')
  END AS profit_loss_reason_mgmt_group_cd
FROM ldl_dig_lec_share.v_rel_webshop_profit_loss_reason_1
WHERE dwh_valid_fg
UNION ALL
SELECT '-1' AS dm__operand0,
 '-1' AS dm__operand1,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand2,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand3,
 ROUND(CAST('-1' AS BIGNUMERIC), 0) AS dm__operand4,
 '' AS dm__operand5,
 '-1' AS dm__operand6,
 '-1' AS dm__operand7;