CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_wawi_cal_month_desc_2 (month_id, language_id, month_name, month_name_short) AS
SELECT month_id,
 language_id,
 month_name,
 month_name_short
FROM ldl_p_lew_core.t_wawi_cal_month_desc_2;