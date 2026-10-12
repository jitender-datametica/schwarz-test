CREATE OR REPLACE VIEW ldl_fe_mstr_ai_reporting.v_ref_score_type_1 (score_type_sid, score_type_name, score_type_descr) AS
SELECT score_type_sid,
 score_type_name,
 score_type_descr
FROM ldl_p_lew_core.t_ref_score_type_1;