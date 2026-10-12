CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_profit_loss_reason_2 AS SELECT CASE
  WHEN profit_loss_reason_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_cd, '-1')
  END AS profit_loss_reason_cd,
 profit_loss_reason_name,
  CASE
  WHEN profit_loss_reason_group_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_group_cd, '-1')
  END AS profit_loss_reason_group_cd,
 profit_loss_reason_group_name,
 profit_loss_type_name
FROM ldl_dig_lec_share.v_dim_profit_loss_reason_2
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1,
 '-1' AS dm__operand2,
 '' AS dm__operand3,
 '' AS dm__operand4;