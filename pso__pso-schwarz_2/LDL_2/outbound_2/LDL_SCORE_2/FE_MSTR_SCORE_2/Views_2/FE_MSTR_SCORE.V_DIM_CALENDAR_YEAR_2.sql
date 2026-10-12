CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_calendar_year_2 AS SELECT cy,
 cy_seq
FROM ldl_score_core.t_dim_calendar_year_2;