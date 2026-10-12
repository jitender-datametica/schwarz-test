CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_lp_approval_fg_desc (approval_fg, approval_fg_desc) AS SELECT
 approval_fg,
 approval_fg_desc
FROM ldl_p_lew_mart_msi.t_msi_ejr_lp_approval_fg_desc;