CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_dim_hauler_2 AS SELECT hauler_sid,
 hauler_nr,
 hauler_abbr_name,
 hauler_short_name,
 hauler_name,
 vat_nr
FROM ldl_score_core.t_dim_hauler_2;