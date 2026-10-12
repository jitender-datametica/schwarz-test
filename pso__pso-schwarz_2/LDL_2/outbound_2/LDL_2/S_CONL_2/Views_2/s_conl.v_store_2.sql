CREATE OR REPLACE VIEW ldl_s_conl.v_store_2 AS SELECT *
FROM ldl_p_lew_bil_ac.v_store_2
WHERE client_id IN (SELECT client_id
   FROM ldl_s_conl.t_user_mapping_2
   WHERE LOWER(user_name) = LOWER(SESSION_USER()));


/*** MSC-WARNING - MSCEWI3045 - MISSING DEPENDENT OBJECT "p_lew_bil_ac.v_warehouse_2" ***/