CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_calendar_week_1 AS SELECT cy_week,
 cy_week_descr,
 cy_week_prev_1w,
 cy_week_prev_1y,
 cy_week_seq
FROM ldl_score_core.t_dim_calendar_week_1;