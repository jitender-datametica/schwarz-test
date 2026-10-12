CREATE OR REPLACE VIEW kfl_production_dbp_view.v_problemgruppe_spr_zu_1 (system_id, mandant_id, problemgruppe_id, spr_id,
problemgruppe_bez) AS SELECT system_id,
 mandant_id,
 problemgruppe_id,
 spr_id,
 problemgruppe_bez
FROM kfl_production_dbp_data.problemgruppe_spr_zu_1;