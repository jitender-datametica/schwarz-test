CREATE OR REPLACE VIEW kfl_production_dbp_view.v_nachrichtenursprung_spr_zu_1 AS SELECT mandant_id,
 spr_id,
 nachrichtenursprung_id,
 nachrichtenursprung_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.nachrichtenursprung_spr_zu_1;