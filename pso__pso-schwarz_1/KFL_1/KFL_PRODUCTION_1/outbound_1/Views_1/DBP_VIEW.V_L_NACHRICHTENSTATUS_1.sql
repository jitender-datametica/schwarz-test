CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_nachrichtenstatus_1 AS SELECT mandant_id,
 nachrichtenstatus_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_nachrichtenstatus_1;