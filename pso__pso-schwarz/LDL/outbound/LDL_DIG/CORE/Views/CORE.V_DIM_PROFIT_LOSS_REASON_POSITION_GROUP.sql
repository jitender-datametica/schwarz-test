CREATE OR REPLACE VIEW ldl_dig_core.v_dim_profit_loss_reason_position_group (profit_loss_reason_pos_group_cd,
profit_loss_reason_pos_group_descr)
OPTIONS(DESCRIPTION = `A VIEW (MINOR DIMENSION) THAT CONTAINS ALL DISTINCT KER POSITIONS THAT ARE USED FOR GROUPING PROFIT/LOSS REASONS IN REPORTS FOR CONTROLLING DEPARTMENT`)
AS SELECT DISTINCT profit_loss_reason_pos_group_cd,
 NULL AS profit_loss_reason_pos_group_descr
FROM ldl_dig_core.t_rel_webshop_profit_loss_reason;