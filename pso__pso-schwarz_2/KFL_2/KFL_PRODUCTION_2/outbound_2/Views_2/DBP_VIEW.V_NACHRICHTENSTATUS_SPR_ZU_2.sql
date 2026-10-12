CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nachrichtenstatus_spr_zu_2 AS SELECT mandant_id,
 spr_id,
 nachrichtenstatus_id,
 nachrichtenstatus_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.nachrichtenstatus_spr_zu_2;