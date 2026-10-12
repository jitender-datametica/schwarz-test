CREATE OR REPLACE VIEW ldl_s_conl.v_warehouse_1 AS SELECT *
FROM ldl_p_lew_bil_ac.v_warehouse_1
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_1
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));