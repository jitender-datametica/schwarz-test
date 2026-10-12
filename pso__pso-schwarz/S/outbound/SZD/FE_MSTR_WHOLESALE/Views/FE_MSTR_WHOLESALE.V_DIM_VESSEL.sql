CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_vessel (resource_item_sid, vessel_nr, vessel_name, loop_name,
vessel_status_cd) AS SELECT resource_item_sid,
 vessel_nr,
 vessel_name,
 loop_name,
 vessel_status_cd
FROM szd_core.t_dim_vessel
WHERE dwh_valid_fg;