CREATE OR REPLACE VIEW ldl_s_conl.v_agg_pos_store_day_sig_asis AS SELECT *
FROM ldl_p_lew_bil_ac.v_agg_pos_store_day_sig_asis
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_agg_store_day_turnover_ext" ***/