CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_profit_loss_reason_group AS SELECT CASE
  WHEN profit_loss_reason_group_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_group_cd, '-1')
  END AS profit_loss_reason_group_cd,
 profit_loss_reason_group_name
FROM ldl_dig_lec_share.v_dim_profit_loss_reason_group
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;