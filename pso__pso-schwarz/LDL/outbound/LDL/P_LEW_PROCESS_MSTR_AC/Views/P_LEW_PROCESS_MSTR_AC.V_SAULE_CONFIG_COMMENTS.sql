CREATE OR REPLACE VIEW ldl_p_lew_process_mstr_ac.v_saule_config_comments (comments, sort, sort2) AS SELECT comments,
 sort,
 sort2
FROM ldl_p_lew_process_mstr.t_saule_config_comments;