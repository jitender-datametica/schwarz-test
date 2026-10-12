CREATE OR REPLACE VIEW ldl_s_conl.v_warehouse AS SELECT *
FROM ldl_p_lew_bil_ac.v_warehouse
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));