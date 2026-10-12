CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_silo_1 (resource_item_sid, silo_cd, silo_name) AS SELECT
 silo_name AS resource_item_sid,
 silo_cd,
 silo_name
FROM produktion_core.t_dim_silo_1;