CREATE OR REPLACE VIEW ldl_p_lew_mart_cm.v_lil_active_flag (active_fg, active_fg_desc, active_fg_desc_en) AS SELECT
 active_fg,
 active_fg_desc,
 active_fg_desc_en
FROM ldl_p_lew_mart_cm.t_lil_active_flag;