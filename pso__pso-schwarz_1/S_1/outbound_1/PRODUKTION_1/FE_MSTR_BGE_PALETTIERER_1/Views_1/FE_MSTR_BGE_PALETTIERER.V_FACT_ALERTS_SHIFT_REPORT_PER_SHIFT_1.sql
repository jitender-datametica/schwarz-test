CREATE OR REPLACE VIEW produktion_fe_mstr_bge_palettierer.v_fact_alerts_shift_report_per_shift_1 AS SELECT SHFT.alerts_day_shift_id
 ,
 COALESCE(SRPS.alerts_shift_report_agreement_txt, '') AS alerts_shift_report_agreement_txt,
 COALESCE(SRPS.alerts_shift_report_next_shift_txt, '') AS alerts_shift_report_next_shift_txt,
 COALESCE(SRPS.alerts_shift_report_out_of_order_txt, '') AS alerts_shift_report_out_of_order_txt,
 COALESCE(SRPS.alerts_shift_report_security_issues, '') AS alerts_shift_report_security_issues
FROM produktion_core.t_dim_alerts_day_shift_1 AS SHFT
 LEFT JOIN produktion_core.t_fact_alerts_shift_report_per_shift_1 AS SRPS ON SHFT.alerts_day_shift_id = SRPS.alerts_day_shift_id;