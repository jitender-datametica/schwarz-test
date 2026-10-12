CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_calendar_month_2 AS SELECT cy_month,
 month_of_year,
 cy,
 bus_year,
 cy_month_descr,
 cy_month_short_descr,
 cy_month_seq
FROM ldl_score_core.t_dim_calendar_month_2;