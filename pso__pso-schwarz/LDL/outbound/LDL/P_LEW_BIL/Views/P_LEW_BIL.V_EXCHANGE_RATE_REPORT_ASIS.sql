CREATE OR REPLACE VIEW ldl_p_lew_bil.v_exchange_rate_report_asis AS SELECT ERKH.client_id,
 ERKH.curr_sid_from,
 ERKH.curr_sid_to,
 ERKH.curr_cd_from,
 ERKH.curr_cd_to,
 ERKH.exchange_rate
FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist AS ERKH
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type AS ERT ON ERKH.client_id = ERT.client_id AND ERKH.x_rate_type_sid =
   ERT.x_rate_type_sid
WHERE CURRENT_DATE BETWEEN ERKH.dwh_valid_from AND ERKH.dwh_valid_to
 AND CURRENT_DATE BETWEEN ERKH.active_from_dt AND ERKH.active_to_dt
 AND ERKH.deleted_fg = 0
 AND UPPER(ERT.src_kurst) = '@BEWE';