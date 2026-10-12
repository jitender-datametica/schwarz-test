CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_busyear_month_week_1 (land_1, client_id, ba_nr, ian, busyear, start_month,
end_month, cal_month, cy_month_seq, cal_week) AS SELECT CAL.land_1,
 CLIENT.client_id,
 CAL.ba_nr,
 CAL.ian,
 CAL.busyear,
 CAL.start_month,
 CAL.end_month,
 CAL.cy_month AS cal_month,
 CAL.cy_month_sequence AS cy_month_seq,
 CAL.cy_week AS cal_week
FROM ldl_scm_core_rel.v_busyear_month_week_1 AS CAL
 INNER JOIN ldl_scm_core.v_client_1 AS CLIENT ON CAL.land_1 = CLIENT.country_cd;