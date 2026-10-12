CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_profit_loss_reason_position_group AS SELECT CASE
  WHEN profit_loss_reason_pos_group_cd = ''
  THEN '-1'
  ELSE IFNULL(profit_loss_reason_pos_group_cd, '-1')
  END AS profit_loss_reason_pos_group_cd,
 CAST(profit_loss_reason_pos_group_descr AS STRING) AS profit_loss_reason_pos_group_descr
FROM ldl_dig_lec_share.v_dim_profit_loss_reason_position_group_core_view
UNION ALL
SELECT '-1' AS dm__operand0,
 '' AS dm__operand1;