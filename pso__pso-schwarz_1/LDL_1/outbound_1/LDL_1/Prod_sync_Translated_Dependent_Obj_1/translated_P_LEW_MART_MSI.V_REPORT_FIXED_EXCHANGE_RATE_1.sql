CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_report_fixed_exchange_rate_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT XR_KN_H.client_id,
 XRTYP.src_kurst,
 XR_KN_H.curr_cd_from,
 XR_KN_H.curr_cd_to,
 XR_KN_H.curr_sid_from,
 XR_KN_H.curr_sid_to,
 XR_KN_H.exchange_rate,
 XR_KN_H.active_from_dt,
 XR_KN_H.active_to_dt,
 XR_KN_H.deleted_fg
FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_1 AS XR_KN_H
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_1 AS XRTYP ON XR_KN_H.client_id = XRTYP.client_id AND XR_KN_H.x_rate_type_sid
    = XRTYP.x_rate_type_sid
WHERE CURRENT_DATE BETWEEN XR_KN_H.dwh_valid_from AND XR_KN_H.dwh_valid_to
 AND XRTYP.src_kurst = '@BEWE';